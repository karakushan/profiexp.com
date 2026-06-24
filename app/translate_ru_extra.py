#!/usr/bin/env python3
"""Extra translations for admin_ru.json and ru.json"""

import json

extra = {
    "Settings": "Настройки",
    "Vendor Management": "Управление поставщиками",
    "Vendor Panel": "Панель поставщика",
    "Vendor Dashboard": "Панель поставщика",
    "Search": "Поиск",
    "Search Here": "Поиск...",
    "Search Menu Here": "Поиск по меню...",
    "Search by title": "Поиск по названию",
    "Search by name": "Поиск по имени",
    "Search by name...": "Поиск по имени...",
    "Search by Category": "Поиск по категории",
    "Search By Email ID": "Поиск по Email",
    "Search By Username": "Поиск по имени",
    "Search By Username or Email ID": "Поиск по имени или Email",
    "Search by Username": "Поиск по имени",
    "Search by Transaction ID": "Поиск по ID транзакции",
    "Search by transaction id...": "Поиск по ID транзакции...",
    "Search by subject or email": "Поиск по теме или email",
    "Search by order number...": "Поиск по номеру заказа...",
    "Search products": "Поиск товаров",
    "Search messages...": "Поиск сообщений...",
    "Search withdraws": "Поиск выводов",
    "Search withdraw id or method name": "Поиск по ID или способу",
    "Search by Approve Status": "Поиск по статусу",
    "Try changing the search or filter, or create a new ticket.": "Измените поиск или создайте новый тикет.",
    "Radius-base searchings will be disabled.": "Поиск по радиусу отключён.",
    "Specifications": "Характеристики",
    "Specification": "Характеристика",
    "Add Specification": "Добавить характеристику",
    "Edit Specification": "Редактировать характеристику",
    "Manage Specifications": "Управление характеристиками",
    "Listing": "Объявление",
    "Listings": "Объявления",
    "NO VENDOR FOUND": "ПОСТАВЩИКИ НЕ НАЙДЕНЫ",
    "NO LISTING FOUND": "ОБЪЯВЛЕНИЯ НЕ НАЙДЕНЫ",
    "NO PRODUCT FOUND": "ТОВАРЫ НЕ НАЙДЕНЫ",
    "NO POST FOUND": "ЗАПИСИ НЕ НАЙДЕНЫ",
    "NO REVIEW FOUND": "ОТЗЫВЫ НЕ НАЙДЕНЫ",
    "No Partner Found": "Партнёры не найдены",
    "No Partner Information Found": "Информация не найдена",
    "No Link Found": "Ссылки не найдены",
    "Only .zip file is allowed": "Только .zip",
    "Sorry, you are offline": "Нет соединения",
    "Sorry, your account has been deactivated": "Аккаунт деактивирован",
    "The email field is required.": "Email обязателен.",
    "The password field is required.": "Пароль обязателен.",
    "The password confirmation does not match.": "Пароли не совпадают.",
    "The password must be at least 6 characters.": "Пароль от 6 символов.",
    "The username field is required.": "Имя обязательно.",
    "This email is already registered.": "Email занят.",
    "This product has no review yet": "Нет отзывов",
    "This username is already taken.": "Имя занято.",
    "This username is not allowed.": "Имя не разрешено.",
    "NO PACKAGE FOUND": "ПАКЕТЫ НЕ НАЙДЕНЫ",
    "Drag & drop to sort the input fields of this form": "Перетащите для сортировки",
    "Drag & Drop the input fields to change the order number": "Перетащите для порядка",
    "Click on the dropdown icon to select a icon.": "Нажмите для выбора иконки.",
    "Click on the dropdown icon to select an icon": "Нажмите для выбора иконки",
    "product_tax_amount": "налог товара",
    "current_price": "текущая цена",
    "feature": "особенность",
    "Remove": "Удалить",
    "Exclusive": "Без учёта",
    "Inclusive": "Включительно",
    "feature image": "изображение особенности",
    "about_company": "о компании",
    "feature_image": "изображение особенности",
}

for fname in ["admin_ru.json", "ru.json"]:
    with open(f"resources/lang/{fname}", "r", encoding="utf-8") as f:
        data = json.load(f)
    count = 0
    for key in data:
        if key in extra and data[key] != extra[key]:
            data[key] = extra[key]
            count += 1
    with open(f"resources/lang/{fname}", "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    print(f"Updated {count} keys in {fname}")
