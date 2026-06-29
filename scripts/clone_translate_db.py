#!/usr/bin/env python3
"""Clone English DB content to Russian (lang=23) and Turkish (lang=24) with translations"""

import pymysql
import json
import re
from copy import deepcopy


# Load translation dictionaries from JSON files
def load_translations(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        data = json.load(f)
    return {k: v for k, v in data.items() if v != k}


ru_dict = load_translations("resources/lang/admin_ru.json")
ru_front = load_translations("resources/lang/ru.json")
tr_dict = load_translations("resources/lang/admin_tr.json")
tr_front = load_translations("resources/lang/tr.json")

# Merge dictionaries
ru_trans = {**ru_dict, **ru_front}
tr_trans = {**tr_dict, **tr_front}

# Add page heading translations
page_tr = {
    "Listings": "İlanlar",
    "Listing": "İlan",
    "Blog": "Blog",
    "Blogs": "Bloglar",
    "Contact": "İletişim",
    "Products": "Ürünler",
    "Product": "Ürün",
    "FAQ": "SSS",
    "FAQs": "SSS",
    "Pricing": "Fiyatlandırma",
    "About Us": "Hakkımızda",
    "About": "Hakkımızda",
    "Vendors": "Satıcılar",
    "Vendor": "Satıcı",
    "Login": "Giriş",
    "Signup": "Kayıt Ol",
    "Register": "Kayıt Ol",
    "Forget Password": "Şifremi Unuttum",
    "Forgot Password": "Şifremi Unuttum",
    "Cart": "Sepet",
    "Checkout": "Ödeme",
    "Dashboard": "Kontrol Paneli",
    "Change Password": "Şifreyi Değiştir",
    "Edit Profile": "Profili Düzenle",
    "Wishlist": "İstek Listesi",
    "Support Ticket": "Destek Talebi",
    "Orders": "Siparişler",
    "Error": "Hata",
    "404": "404",
    "Page Not Found": "Sayfa Bulunamadı",
    "Search": "Ara",
    "Home": "Ana Sayfa",
}
page_ru = {
    "Listings": "Объявления",
    "Listing": "Объявление",
    "Blog": "Блог",
    "Blogs": "Блоги",
    "Contact": "Контакты",
    "Products": "Товары",
    "Product": "Товар",
    "FAQ": "FAQ",
    "FAQs": "FAQ",
    "Pricing": "Цены",
    "About Us": "О нас",
    "About": "О нас",
    "Vendors": "Поставщики",
    "Vendor": "Поставщик",
    "Login": "Войти",
    "Signup": "Регистрация",
    "Register": "Регистрация",
    "Forget Password": "Забыли пароль",
    "Forgot Password": "Забыли пароль",
    "Cart": "Корзина",
    "Checkout": "Оформление",
    "Dashboard": "Панель управления",
    "Change Password": "Сменить пароль",
    "Edit Profile": "Редактировать профиль",
    "Wishlist": "Избранное",
    "Support Ticket": "Тикет поддержки",
    "Orders": "Заказы",
    "Error": "Ошибка",
    "404": "404",
    "Page Not Found": "Страница не найдена",
    "Search": "Поиск",
    "Home": "Главная",
}

ru_trans.update(page_ru)
tr_trans.update(page_tr)

# Category name translations
cat_ru = {
    "Restaurant": "Ресторан",
    "Restaurants": "Рестораны",
    "Hotel": "Отель",
    "Hotels": "Отели",
    "Real Estate": "Недвижимость",
    "Real estate": "Недвижимость",
    "Beauty & Spa": "Красота и Спа",
    "Beauty and Spa": "Красота и Спа",
    "Health and Medical": "Здоровье и медицина",
    "Health & Medical": "Здоровье и медицина",
    "Automotive": "Автомобили",
    "Car": "Автомобиль",
    "Education": "Образование",
    "Shopping": "Магазины",
    "Doctor": "Доктор",
    "Hospital": "Больница",
    "Lawyer": "Юрист",
    "Attorney": "Адвокат",
}
cat_tr = {
    "Restaurant": "Restoran",
    "Restaurants": "Restoranlar",
    "Hotel": "Otel",
    "Hotels": "Oteller",
    "Real Estate": "Emlak",
    "Real estate": "Emlak",
    "Beauty & Spa": "Güzellik ve Spa",
    "Beauty and Spa": "Güzellik ve Spa",
    "Health and Medical": "Sağlık ve Tıp",
    "Health & Medical": "Sağlık ve Tıp",
    "Automotive": "Otomotiv",
    "Car": "Araba",
    "Education": "Eğitim",
    "Shopping": "Alışveriş",
    "Doctor": "Doktor",
    "Hospital": "Hastane",
    "Lawyer": "Avukat",
    "Attorney": "Avukat",
}
ru_trans.update(cat_ru)
tr_trans.update(cat_tr)

# Day name translations
days_ru = {
    "Monday": "Понедельник",
    "Tuesday": "Вторник",
    "Wednesday": "Среда",
    "Thursday": "Четверг",
    "Friday": "Пятница",
    "Saturday": "Суббота",
    "Sunday": "Воскресенье",
}
days_tr = {
    "Monday": "Pazartesi",
    "Tuesday": "Salı",
    "Wednesday": "Çarşamba",
    "Thursday": "Perşembe",
    "Friday": "Cuma",
    "Saturday": "Cumartesi",
    "Sunday": "Pazar",
}
ru_trans.update(days_ru)
tr_trans.update(days_tr)

# Month translations
months_ru = {
    "January": "Январь",
    "February": "Февраль",
    "March": "Март",
    "April": "Апрель",
    "May": "Май",
    "June": "Июнь",
    "July": "Июль",
    "August": "Август",
    "September": "Сентябрь",
    "October": "Октябрь",
    "November": "Ноябрь",
    "December": "Декабрь",
}
months_tr = {
    "January": "Ocak",
    "February": "Şubat",
    "March": "Mart",
    "April": "Nisan",
    "May": "Mayıs",
    "June": "Haziran",
    "July": "Temmuz",
    "August": "Ağustos",
    "September": "Eylül",
    "October": "Ekim",
    "November": "Kasım",
    "December": "Aralık",
}
ru_trans.update(months_ru)
tr_trans.update(months_tr)

# City/Country translations
city_ru = {
    "New York": "Нью-Йорк",
    "Los Angeles": "Лос-Анджелес",
    "Chicago": "Чикаго",
    "London": "Лондон",
    "Paris": "Париж",
    "Tokyo": "Токио",
    "Dubai": "Дубай",
    "Sydney": "Сидней",
}
city_tr = {
    "New York": "New York",
    "Los Angeles": "Los Angeles",
    "Chicago": "Chicago",
    "London": "Londra",
    "Paris": "Paris",
    "Tokyo": "Tokyo",
    "Dubai": "Dubai",
    "Sydney": "Sidney",
}
country_ru = {
    "United States": "США",
    "United Kingdom": "Великобритания",
    "Canada": "Канада",
    "Australia": "Австралия",
    "France": "Франция",
    "Germany": "Германия",
    "Japan": "Япония",
    "UAE": "ОАЭ",
    "Egypt": "Египет",
    "Iraq": "Ирак",
    "Jordan": "Иордания",
}
country_tr = {
    "United States": "Amerika Birleşik Devletleri",
    "United Kingdom": "Birleşik Krallık",
    "Canada": "Kanada",
    "Australia": "Avustralya",
    "France": "Fransa",
    "Germany": "Almanya",
    "Japan": "Japonya",
    "UAE": "BAE",
    "Egypt": "Mısır",
    "Iraq": "Irak",
    "Jordan": "Ürdün",
}
ru_trans.update(city_ru)
ru_trans.update(country_ru)
tr_trans.update(city_tr)
tr_trans.update(country_tr)


def translate_text(text, lang):
    """Translate a text string using dictionary"""
    if not text or not isinstance(text, str):
        return text
    dictionary = ru_trans if lang == "ru" else tr_trans
    # Try exact match
    if text in dictionary:
        return dictionary[text]
    # Try word-by-word for short strings
    words = text.split()
    if len(words) <= 5 and all(w in dictionary for w in words):
        return " ".join(dictionary[w] for w in words)
    return text


conn = pymysql.connect(
    host="127.0.0.1",
    port=3307,
    user="bulistio",
    password="bulistio",
    database="bulistio",
    charset="utf8mb4",
)
cursor = conn.cursor()

# Tables to process (all tables with language_id, excluding menu_builders which is handled by LanguageController)
tables = [
    "aminites",
    "blog_categories",
    "blog_informations",
    "blog_sections",
    "call_to_action_sections",
    "category_sections",
    "cities",
    "claim_listings",
    "cookie_alerts",
    "counter_informations",
    "counter_sections",
    "countries",
    "faqs",
    "feature_sections",
    "footer_contents",
    "forms",
    "hero_sections",
    "listing_categories",
    "listing_contents",
    "listing_faqs",
    "listing_feature_contents",
    "listing_product_contents",
    "listing_sections",
    "location_sections",
    "mobile_interface_settings",
    "package_sections",
    "page_contents",
    "page_headings",
    "popups",
    "product_categories",
    "product_contents",
    "product_shipping_charges",
    "quick_links",
    "seos",
    "states",
    "testimonials",
    "testimonial_sections",
    "vendor_infos",
    "video_sections",
    "work_processes",
    "work_process_sections",
]

# Text columns for each table (columns that should be translated)
text_columns = {
    "aminites": ["title"],
    "blog_categories": ["name"],
    "blog_informations": ["title", "author", "meta_keywords", "meta_description"],
    "blog_sections": ["title", "button_text"],
    "call_to_action_sections": ["title", "subtitle", "text", "button_name"],
    "category_sections": ["title", "subtitle", "text", "button_text"],
    "cities": ["name"],
    "claim_listings": ["information"],
    "cookie_alerts": ["cookie_alert_text", "cookie_alert_btn_text"],
    "counter_informations": ["title"],
    "counter_sections": ["title", "subtitle"],
    "countries": ["name"],
    "faqs": ["question", "answer"],
    "feature_sections": ["title", "subtitle", "button_text"],
    "footer_contents": ["about_company", "copyright_text"],
    "forms": ["name"],
    "hero_sections": ["title", "text"],
    "listing_categories": ["name"],
    "listing_contents": [
        "title",
        "description",
        "address",
        "summary",
        "features",
        "meta_keyword",
        "meta_description",
    ],
    "listing_faqs": ["question", "answer"],
    "listing_feature_contents": ["feature_heading", "feature_value"],
    "listing_product_contents": [
        "title",
        "content",
        "meta_keyword",
        "meta_description",
    ],
    "listing_sections": ["title", "subtitle", "button_text"],
    "location_sections": ["title"],
    "mobile_interface_settings": [
        "category_listing_section_title",
        "featured_listing_section_title",
        "banner_title",
        "banner_button_text",
    ],
    "package_sections": ["title", "subtitle", "button_text"],
    "page_contents": ["title", "meta_keywords", "meta_description"],
    "page_headings": [
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
    "popups": ["name", "title", "text", "button_text"],
    "product_categories": ["name"],
    "product_contents": [
        "title",
        "summary",
        "content",
        "meta_keywords",
        "meta_description",
    ],
    "product_shipping_charges": ["title", "short_text"],
    "quick_links": ["title"],
    "seos": [
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
    "states": ["name"],
    "testimonials": ["name", "occupation", "comment"],
    "testimonial_sections": ["title", "subtitle", "clients"],
    "vendor_infos": ["name", "country", "city", "state", "address", "details"],
    "video_sections": ["title", "subtitle", "button_name"],
    "work_processes": ["title", "text"],
    "work_process_sections": ["title", "button_text"],
}

# Get column names for each table
table_columns = {}
for table in tables:
    cursor.execute(f"SHOW COLUMNS FROM `{table}`")
    cols = [row[0] for row in cursor.fetchall()]
    table_columns[table] = cols

total_ru = 0
total_tr = 0

for table in tables:
    # Get English records
    cursor.execute(f"SELECT * FROM `{table}` WHERE language_id = 20")
    en_records = cursor.fetchall()

    if not en_records:
        continue

    cols = table_columns[table]
    translate_cols = text_columns.get(table, [])

    for record in en_records:
        record_dict = dict(zip(cols, record))

        # Clone for Russian
        ru_record = record_dict.copy()
        ru_record["language_id"] = 23
        # Remove id so auto-increment works
        if "id" in ru_record:
            del ru_record["id"]
        # Translate text columns
        for col in translate_cols:
            if col in ru_record and ru_record[col]:
                ru_record[col] = translate_text(ru_record[col], "ru")

        # Clone for Turkish
        tr_record = record_dict.copy()
        tr_record["language_id"] = 24
        if "id" in tr_record:
            del tr_record["id"]
        for col in translate_cols:
            if col in tr_record and tr_record[col]:
                tr_record[col] = translate_text(tr_record[col], "tr")

        # Insert Russian record
        placeholders = ", ".join(["%s"] * len(ru_record))
        columns_str = ", ".join([f"`{k}`" for k in ru_record.keys()])
        try:
            cursor.execute(
                f"INSERT INTO `{table}` ({columns_str}) VALUES ({placeholders})",
                list(ru_record.values()),
            )
            total_ru += 1
        except Exception as e:
            print(f"SKIP RU {table}: {e}")

        # Insert Turkish record
        try:
            cursor.execute(
                f"INSERT INTO `{table}` ({columns_str}) VALUES ({placeholders})",
                list(tr_record.values()),
            )
            total_tr += 1
        except Exception as e:
            print(f"SKIP TR {table}: {e}")

conn.commit()
cursor.close()
conn.close()

print(f"Created {total_ru} Russian records")
print(f"Created {total_tr} Turkish records")
print("Done!")
