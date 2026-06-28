#!/usr/bin/env python3
"""
Generate Ukrainian INSERT statements for all DB translation tables.
Pulls russian (language_id=23) rows from MySQL, translates text columns
via MyMemory API (ru->uk) with caching, and writes SQL inserts with language_id=105.
Admin (admin_* / admin panel) is NOT touched.
"""

import json
import os
import subprocess
import sys
import time
import urllib.parse
import urllib.request

CACHE_PATH = "/tmp/uk_translate_cache.json"
cache = {}
if os.path.exists(CACHE_PATH):
    with open(CACHE_PATH, "r", encoding="utf-8") as f:
        cache = json.load(f)


def tr(text):
    if not text:
        return text
    if text in cache:
        return cache[text]
    # skip already-uk / latin / placeholder
    try:
        q = urllib.parse.quote(text)
        url = f"https://api.mymemory.translated.net/get?q={q}&langpair=ru|uk"
        req = urllib.request.Request(url, headers={"User-Agent": "Mozilla/5.0"})
        with urllib.request.urlopen(req, timeout=30) as resp:
            data = json.load(resp)
        out = data["responseData"]["translatedText"]
        # mymemory returns text with original case for short / known phrases
        cache[text] = out
        time.sleep(0.3)
        return out
    except Exception as e:
        print(f"[warn] failed to translate {text!r}: {e}", file=sys.stderr)
        return text


def mysql_query(sql):
    cmd = [
        "docker",
        "exec",
        "-i",
        "bulistio-db",
        "mysql",
        "-uroot",
        "-proot",
        "bulistio",
        "--default-character-set=utf8mb4",
        "-N",
        "-e",
        sql,
    ]
    res = subprocess.run(cmd, capture_output=True, text=True)
    if res.returncode != 0:
        print(f"[mysql err] {res.stderr}", file=sys.stderr)
    return res.stdout


def esc(s):
    if s is None:
        return "NULL"
    return "'" + s.replace("\\", "\\\\").replace("'", "''") + "'"


# (table, [text_columns]) — exclude id/language_id/created_at/updated_at and
# non-text columns (icon, image, slug, status, serial_number, urls, etc.)
TABLES = [
    ("aminites", ["title"]),
    ("blog_categories", ["name"]),
    (
        "blog_informations",
        ["title", "author", "content", "meta_keywords", "meta_description"],
    ),
    ("cookie_alerts", ["cookie_alert_btn_text", "cookie_alert_text"]),
    ("counter_informations", ["title"]),
    ("faqs", ["question", "answer"]),
    ("footer_contents", ["about_company", "copyright_text"]),
    ("listing_categories", ["name", "meta_title", "meta_description"]),
    ("listing_sections", ["title", "subtitle", "button_text"]),
    (
        "mobile_interface_settings",
        [
            "category_listing_section_title",
            "featured_listing_section_title",
            "banner_title",
            "banner_button_text",
        ],
    ),
    ("page_contents", ["title", "content", "meta_keywords", "meta_description"]),
    (
        "page_headings",
        [
            "listing_page_title",
            "blog_page_title",
            "contact_page_title",
            "products_page_title",
            "error_page_title",
            "pricing_page_title",
            "faq_page_title",
            "forget_password_page_title",
            "vendor_forget_password_page_title",
            "login_page_title",
            "signup_page_title",
            "vendor_login_page_title",
            "vendor_signup_page_title",
            "cart_page_title",
            "checkout_page_title",
            "vendor_page_title",
            "about_us_title",
            "wishlist_page_title",
            "dashboard_page_title",
            "orders_page_title",
            "support_ticket_page_title",
            "support_ticket_create_page_title",
            "change_password_page_title",
            "edit_profile_page_title",
        ],
    ),
    ("popups", ["name", "title", "text", "button_text"]),
    ("product_categories", ["name"]),
    ("product_shipping_charges", ["title", "short_text"]),
    ("quick_links", ["title"]),
    (
        "seos",
        [
            "meta_keyword_home",
            "meta_description_home",
            "meta_keyword_pricing",
            "meta_description_pricing",
            "meta_keyword_listings",
            "meta_description_listings",
            "meta_keyword_products",
            "meta_description_products",
            "meta_keyword_blog",
            "meta_description_blog",
            "meta_keyword_faq",
            "meta_description_faq",
            "meta_keyword_contact",
            "meta_description_contact",
            "meta_keyword_login",
            "meta_description_login",
            "meta_keyword_signup",
            "meta_description_signup",
            "meta_keyword_forget_password",
            "meta_description_forget_password",
            "meta_keywords_vendor_login",
            "meta_description_vendor_login",
            "meta_keywords_vendor_signup",
            "meta_description_vendor_signup",
            "meta_keywords_vendor_forget_password",
            "meta_descriptions_vendor_forget_password",
            "meta_keywords_vendor_page",
            "meta_description_vendor_page",
            "meta_keywords_about_page",
            "meta_description_about_page",
        ],
    ),
    ("testimonials", ["name", "occupation", "comment"]),
    ("work_processes", ["title", "text"]),
    # Listing/product/vendor content — these have parent FKs; we copy them too
    (
        "listing_contents",
        [
            "title",
            "description",
            "address",
            "meta_keyword",
            "meta_description",
            "features",
            "summary",
        ],
    ),
    ("listing_faqs", ["question", "answer"]),
    ("listing_feature_contents", ["feature_heading", "feature_value"]),
    (
        "listing_product_contents",
        ["title", "content", "meta_keyword", "meta_description"],
    ),
    (
        "product_contents",
        ["title", "summary", "content", "meta_keywords", "meta_description"],
    ),
    (
        "vendor_infos",
        ["name", "country", "city", "state", "zip_code", "address", "details"],
    ),
    ("cities", ["name"]),
    ("countries", ["name"]),
    ("states", ["name"]),
    # claim_listings / forms handled separately if needed
    ("claim_listings", ["name", "phone", "email", "message"]),
    ("forms", ["name"]),
]

# Persist cache every N rows
SAVE_EVERY = 20
counter = 0


def save_cache():
    with open(CACHE_PATH, "w", encoding="utf-8") as f:
        json.dump(cache, f, ensure_ascii=False, indent=2)


out_lines = ["SET NAMES utf8mb4;", "SET FOREIGN_KEY_CHECKS=0;", ""]

for table, cols in TABLES:
    # Check if uk rows already exist
    uk_count = mysql_query(
        f"SELECT COUNT(*) FROM {table} WHERE language_id=105;"
    ).strip()
    if uk_count and int(uk_count) > 0:
        print(f"[skip] {table}: already has {uk_count} uk rows", file=sys.stderr)
        continue

    # Fetch ru rows
    col_list = ", ".join(cols)
    rows_sql = f"SELECT {col_list} FROM {table} WHERE language_id=23;"
    raw = mysql_query(rows_sql)
    if not raw.strip():
        print(f"[empty] {table}: no ru rows", file=sys.stderr)
        continue

    lines = raw.rstrip("\n").split("\n")
    values_lines = []
    for line in lines:
        # Parse tab-separated row (mysql -N output uses TAB)
        parts = line.split("\t")
        # NULL comes back as "NULL" string from mysql -N? Actually it prints "NULL".
        row_vals = []
        for i, col in enumerate(cols):
            if i >= len(parts):
                row_vals.append("NULL")
                continue
            val = parts[i]
            if val == "NULL":
                row_vals.append("NULL")
                continue
            translated = tr(val)
            row_vals.append(esc(translated))
            counter += 1
            if counter % SAVE_EVERY == 0:
                save_cache()
        values_lines.append(f"(105, {', '.join(row_vals)})")

    out_lines.append(f"-- {table}")
    out_lines.append(f"INSERT INTO {table} (language_id, {col_list}) VALUES")
    out_lines.append(",\n".join(values_lines) + ";")
    out_lines.append("")
    print(f"[ok] {table}: {len(values_lines)} rows", file=sys.stderr)

save_cache()

sql_path = (
    "/Users/admin/Documents/dev/profiexp.com/app/database/sql/uk_translations_full.sql"
)
with open(sql_path, "w", encoding="utf-8") as f:
    f.write("\n".join(out_lines))
print(f"\nWrote SQL to {sql_path}", file=sys.stderr)
