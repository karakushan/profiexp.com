#!/usr/bin/env python3
"""Translate the cloned Russian/Turkish DB records with content-specific translations"""

import pymysql

content_ru = {
    # Hero
    "Are You Looking For A business?": "Ищете бизнес?",
    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium": "Найдите лучшие предложения в вашем городе",
    # Category section
    "Most Popular Categories": "Самые популярные категории",
    # Listing section
    "Trending Latest Listing": "Актуальные объявления",
    "All Listings": "Все объявления",
    # Location section
    "Explore Most Popo": "Популярные места",
    # Package section
    "Most Affordable Package": "Самые доступные пакеты",
    # Blog section
    "Read our latest blogs": "Читайте наши последние блоги",
    "Mores": "Больше",
    # Feature section
    "Our top listing": "Наши лучшие объявления",
    # Testimonial section
    "What Clients Say About Bulistio Packages": "Что клиенты говорят о пакетах Profiexp",
    # Work process section
    "How Bulistio Works": "Как работает Profiexp",
    "Explore Listings": "Изучить объявления",
    # Work process items
    "Explore Selected Place": "Изучите выбранное место",
    "Select Favorite Place": "Выберите любимое место",
    "Choose A Category": "Выберите категорию",
    "They are definitely recommend them if you are looking for a new car": "Рекомендуем, если вы ищете новый автомобиль",
    "They definitely recommend them if you are looking for a new car": "Рекомендуем, если вы ищете новый автомобиль",
    # Counter section
    "See Our Achievements": "Наши достижения",
    "Awards Winning": "Наград получено",
    "Happy Users": "Довольных пользователей",
    "Active Members": "Активных участников",
    "Total Listing": "Всего объявлений",
    # CTA section
    "Find Your Favorite Traveling Place": "Найдите любимое место для путешествий",
    "We highly recommend Carlist. We've used them for many years.": "Мы рекомендуем Profiexp. Мы используем его много лет.",
    # Video section
    "Explore Your Favorite Restaurant Listsss": "Изучите любимые рестораны",
    # Cookie alert
    "We use cookies to give you the best online experience.": "Мы используем cookie для лучшего опыта.",
    "I Agree": "Я согласен",
    # Amenities
    "Swimming Pool": "Бассейн",
    "Comfortable Seating": "Удобные сиденья",
    "Free Wifi": "Бесплатный Wi-Fi",
    "Parking Facilities": "Парковка",
    "Prayer Room": "Молельная комната",
    "Pharmacy": "Аптека",
    "Multilingual Staff": "Многоязычный персонал",
    "Resturant": "Ресторан",
    "Private Dining Room": "Отдельный обеденный зал",
    "Group Exercise Studios": "Студии групповых занятий",
    "Locker Rooms": "Раздевалки",
    # Product categories
    "Hospital Equipment": "Медицинское оборудование",
    "Gym Equipment": "Спортивное оборудование",
    "Saloon Equipment": "Оборудование для салонов",
    # Shipping
    "Free Shipping": "Бесплатная доставка",
    "Standard Shipping": "Стандартная доставка",
    "2-Day Shipping": "Доставка за 2 дня",
    "Same Day Shipping": "Доставка в тот же день",
    # Categories missing
    "salon": "Салон",
    "Travel": "Путешествия",
    "Gymnasium": "Спортзал",
    # Footer
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.": "Давно установлено, что читатель отвлекается на читаемый контент страницы при просмотре макета.",
    "<p>Copyright ©2026. All Rights Reserved.</p>": "<p>Copyright ©2026. Все права защищены.</p>",
    # SEO
    "Home Descriptions": "Описание главной страницы",
    # Vendor info
    "Bangladesh": "Бангладеш",
    "Pakistan": "Пакистан",
    "India": "Индия",
    "Victoria": "Виктория",
    "Andhra Pradesh": "Андхра-Прадеш",
    "California": "Калифорния",
    "Florida": "Флорида",
    "Melbourne": "Мельбурн",
    "Anantapuram": "Анантапурам",
    "Cox's Bazar": "Кокс-Базар",
    "Skardu": "Скарду",
    "Dhaka": "Дакка",
    "San Diego": "Сан-Диего",
    # FAQ questions
    "What is Bulistio app?": "Что такое приложение Profiexp?",
    "How to Purchase this App ?": "Как приобрести это приложение?",
    "How do I Make a Premium User?": "Как стать премиум-пользователем?",
    "How to Debug this App?": "Как отладить приложение?",
    "Can I make an Appointment?": "Можно ли записаться на приём?",
    "What's the Business Policies?": "Какова бизнес-политика?",
    "To list your car, simply create an account, fill in the details, and upload photos.": "Чтобы разместить автомобиль, создайте аккаунт, заполните данные и загрузите фото.",
    "Yes, you can list multiple cars using a single account, making it convenient for dealerships and individual sellers.": "Да, можно разместить несколько автомобилей с одного аккаунта.",
    "We offer both free and premium listing options. Premium listings provide enhanced visibility and additional features.": "У нас есть бесплатные и премиум-размещения. Премиум даёт повышенную видимость.",
    "It's important to provide detailed information about your car, including make, model, year, condition, mileage, and clear photos.": "Важно предоставить подробную информацию об автомобиле: марка, модель, год, состояние, пробег и чёткие фото.",
    "The duration of your car listing depends on the package you select.": "Длительность размещения зависит от выбранного пакета.",
    "Yes, you can edit your listing at any time to update information, change pricing, or add new photos.": "Да, вы можете редактировать объявление в любое время.",
    "Interested buyers can contact you through the contact information provided in your listing.": "Заинтересованные покупатели свяжутся с вами через контакты в объявлении.",
    # Common amenity names
    "Parking": "Парковка",
    "WiFi": "Wi-Fi",
    "Air Conditioning": "Кондиционер",
    "Heating": "Отопление",
    "Elevator": "Лифт",
    "Security": "Охрана",
    "Garden": "Сад",
    "Balcony": "Балкон",
    "Terrace": "Терраса",
    "Furnished": "Меблировано",
    "Pet Friendly": "Можно с животными",
    "Smoking Allowed": "Курение разрешено",
    "Laundry": "Прачечная",
    "Dishwasher": "Посудомоечная машина",
    "TV": "Телевизор",
    "Internet": "Интернет",
    "Breakfast Included": "Завтрак включён",
}

content_tr = {
    # Hero
    "Are You Looking For A business?": "Bir işletme mi arıyorsunuz?",
    "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium": "Şehrinizdeki en iyi fırsatları bulun",
    # Category section
    "Most Popular Categories": "En Popüler Kategoriler",
    # Listing section
    "Trending Latest Listing": "Trend İlanlar",
    "All Listings": "Tüm İlanlar",
    # Location section
    "Explore Most Popo": "Popüler Yerleri Keşfedin",
    # Package section
    "Most Affordable Package": "En Uygun Paket",
    # Blog section
    "Read our latest blogs": "Son bloglarımızı okuyun",
    "Mores": "Daha Fazla",
    # Feature section
    "Our top listing": "En iyi ilanlarımız",
    # Testimonial section
    "What Clients Say About Bulistio Packages": "Müşteriler Profiexp Paketleri Hakkında Ne Diyor",
    # Work process section
    "How Bulistio Works": "Profiexp Nasıl Çalışır",
    "Explore Listings": "İlanları Keşfet",
    # Work process items
    "Explore Selected Place": "Seçili Yeri Keşfedin",
    "Select Favorite Place": "Favori Yeri Seçin",
    "Choose A Category": "Kategori Seçin",
    "They are definitely recommend them if you are looking for a new car": "Yeni bir araba arıyorsanız tavsiye ederiz",
    "They definitely recommend them if you are looking for a new car": "Yeni bir araba arıyorsanız tavsiye ederiz",
    # Counter section
    "See Our Achievements": "Başarılarımız",
    "Awards Winning": "Kazanılan Ödüller",
    "Happy Users": "Mutlu Kullanıcılar",
    "Active Members": "Aktif Üyeler",
    "Total Listing": "Toplam İlan",
    # CTA section
    "Find Your Favorite Traveling Place": "Favori Seyahat Yerinizi Bulun",
    "We highly recommend Carlist. We've used them for many years.": "Profiexp'i şiddetle tavsiye ediyoruz. Yıllardır kullanıyoruz.",
    # Video section
    "Explore Your Favorite Restaurant Listsss": "Favori Restoranlarınızı Keşfedin",
    # Cookie alert
    "We use cookies to give you the best online experience.": "En iyi çevrimiçi deneyim için çerez kullanıyoruz.",
    "I Agree": "Kabul Ediyorum",
    # Amenities
    "Swimming Pool": "Yüzme Havuzu",
    "Comfortable Seating": "Rahat Oturma",
    "Free Wifi": "Ücretsiz WiFi",
    "Parking Facilities": "Park Yeri",
    "Prayer Room": "İbadet Odası",
    "Pharmacy": "Eczane",
    "Multilingual Staff": "Çok Dilli Personel",
    "Resturant": "Restoran",
    "Private Dining Room": "Özel Yemek Odası",
    "Group Exercise Studios": "Grup Egzersiz Stüdyoları",
    "Locker Rooms": "Soyunma Odaları",
    # Product categories
    "Hospital Equipment": "Hastane Ekipmanı",
    "Gym Equipment": "Spor Ekipmanı",
    "Saloon Equipment": "Salon Ekipmanı",
    # Shipping
    "Free Shipping": "Ücretsiz Kargo",
    "Standard Shipping": "Standart Kargo",
    "2-Day Shipping": "2 Günlük Kargo",
    "Same Day Shipping": "Aynı Gün Kargo",
    # Categories missing
    "salon": "Salon",
    "Travel": "Seyahat",
    "Gymnasium": "Spor Salonu",
    # Footer
    "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.": "Bir sayfanın düzenine bakarken okuyucunun okunabilir içerikten dikkatinin dağılacağı uzun zamandır bilinen bir gerçektir.",
    "<p>Copyright ©2026. All Rights Reserved.</p>": "<p>Copyright ©2026. Tüm Hakları Saklıdır.</p>",
    # SEO
    "Home Descriptions": "Ana Sayfa Açıklamaları",
    # Vendor info
    "Bangladesh": "Bangladeş",
    "Pakistan": "Pakistan",
    "India": "Hindistan",
    "Victoria": "Victoria",
    "Andhra Pradesh": "Andhra Pradeş",
    "California": "Kaliforniya",
    "Florida": "Florida",
    "Melbourne": "Melbourne",
    "Anantapuram": "Anantapuram",
    "Cox's Bazar": "Cox's Bazar",
    "Skardu": "Skardu",
    "Dhaka": "Dakka",
    "San Diego": "San Diego",
    # FAQ questions
    "What is Bulistio app?": "Profiexp uygulaması nedir?",
    "How to Purchase this App ?": "Bu uygulama nasıl satın alınır?",
    "How do I Make a Premium User?": "Nasıl Premium Kullanıcı olurum?",
    "How to Debug this App?": "Bu uygulama nasıl hata ayıklanır?",
    "Can I make an Appointment?": "Randevu alabilir miyim?",
    "What's the Business Policies?": "İş politikaları nelerdir?",
    "To list your car, simply create an account, fill in the details, and upload photos.": "Arabanızı listelemek için hesap oluşturun, detayları doldurun ve fotoğraf yükleyin.",
    "Yes, you can list multiple cars using a single account, making it convenient for dealerships and individual sellers.": "Tek hesapla birden fazla araba listeleyebilirsiniz.",
    "We offer both free and premium listing options. Premium listings provide enhanced visibility and additional features.": "Ücretsiz ve premium listeleme seçenekleri sunuyoruz.",
    "It's important to provide detailed information about your car, including make, model, year, condition, mileage, and clear photos.": "Arabanız hakkında detaylı bilgi vermeniz önemlidir.",
    "The duration of your car listing depends on the package you select.": "İlan süreniz seçtiğiniz pakete bağlıdır.",
    "Yes, you can edit your listing at any time to update information, change pricing, or add new photos.": "İlanınızı istediğiniz zaman düzenleyebilirsiniz.",
    "Interested buyers can contact you through the contact information provided in your listing.": "Alıcılar ilanınızdaki iletişim bilgileriyle size ulaşabilir.",
    # Common amenity names
    "Parking": "Otopark",
    "WiFi": "WiFi",
    "Air Conditioning": "Klima",
    "Heating": "Isıtma",
    "Elevator": "Asansör",
    "Security": "Güvenlik",
    "Garden": "Bahçe",
    "Balcony": "Balkon",
    "Terrace": "Teras",
    "Furnished": "Mobilyalı",
    "Pet Friendly": "Evcil Hayvan Dostu",
    "Smoking Allowed": "Sigara İçilebilir",
    "Laundry": "Çamaşırhane",
    "Dishwasher": "Bulaşık Makinesi",
    "TV": "TV",
    "Internet": "İnternet",
    "Breakfast Included": "Kahvaltı Dahil",
}

# Text columns for each table (same as before)
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
    "listing_contents": ["title", "description", "address", "summary", "features"],
    "listing_faqs": ["question", "answer"],
    "listing_feature_contents": ["feature_heading", "feature_value"],
    "listing_product_contents": ["title", "content"],
    "listing_sections": ["title", "subtitle", "button_text"],
    "location_sections": ["title"],
    "mobile_interface_settings": [
        "category_listing_section_title",
        "featured_listing_section_title",
        "banner_title",
        "banner_button_text",
    ],
    "package_sections": ["title", "subtitle", "button_text"],
    "page_contents": ["title"],
    "page_headings": [
        "listing_page_title",
        "blog_page_title",
        "contact_page_title",
        "products_page_title",
        "error_page_title",
        "pricing_page_title",
        "faq_page_title",
    ],
    "popups": ["name", "title", "text", "button_text"],
    "product_categories": ["name"],
    "product_contents": ["title", "summary", "content"],
    "product_shipping_charges": ["title", "short_text"],
    "quick_links": ["title"],
    "seos": ["meta_description_home"],
    "states": ["name"],
    "testimonials": ["name", "occupation", "comment"],
    "testimonial_sections": ["title", "subtitle", "clients"],
    "vendor_infos": ["name", "country", "city", "state", "address", "details"],
    "video_sections": ["title", "subtitle", "button_name"],
    "work_processes": ["title", "text"],
    "work_process_sections": ["title", "button_text"],
}

# Also translate listing_contents meta_keyword, meta_description
text_columns["listing_contents"].extend(["meta_keyword", "meta_description"])
text_columns["listing_feature_contents"] = ["feature_heading", "feature_value"]
text_columns["listing_product_contents"].extend(["meta_keyword", "meta_description"])
text_columns["page_headings"].extend(
    [
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
    ]
)
text_columns["seos"] = [
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
]


def translate_text(text, lang_dict):
    """Translate using exact match or word-by-word"""
    if not text or not isinstance(text, str):
        return text
    if text in lang_dict:
        return lang_dict[text]
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

tables = list(text_columns.keys())

ru_count = 0
tr_count = 0

for table in tables:
    cols = text_columns.get(table, [])
    if not cols:
        continue

    cursor.execute(f"SHOW COLUMNS FROM `{table}`")
    all_cols = [row[0] for row in cursor.fetchall()]

    # Update Russian records (language_id=23)
    cursor.execute(f"SELECT * FROM `{table}` WHERE language_id = 23")
    ru_records = cursor.fetchall()

    for record in ru_records:
        record_dict = dict(zip(all_cols, record))
        updates = {}
        for col in cols:
            if col in record_dict and record_dict[col]:
                translated = translate_text(record_dict[col], content_ru)
                if translated != record_dict[col]:
                    updates[col] = translated

        if updates:
            set_clause = ", ".join([f"`{k}` = %s" for k in updates.keys()])
            cursor.execute(
                f"UPDATE `{table}` SET {set_clause} WHERE id = %s",
                list(updates.values()) + [record_dict["id"]],
            )
            ru_count += 1

    # Update Turkish records (language_id=24)
    cursor.execute(f"SELECT * FROM `{table}` WHERE language_id = 24")
    tr_records = cursor.fetchall()

    for record in tr_records:
        record_dict = dict(zip(all_cols, record))
        updates = {}
        for col in cols:
            if col in record_dict and record_dict[col]:
                translated = translate_text(record_dict[col], content_tr)
                if translated != record_dict[col]:
                    updates[col] = translated

        if updates:
            set_clause = ", ".join([f"`{k}` = %s" for k in updates.keys()])
            cursor.execute(
                f"UPDATE `{table}` SET {set_clause} WHERE id = %s",
                list(updates.values()) + [record_dict["id"]],
            )
            tr_count += 1

conn.commit()
cursor.close()
conn.close()
print(f"Updated {ru_count} Russian records")
print(f"Updated {tr_count} Turkish records")
print("Content translations applied!")
