<?php

return [

    /*
     *
     * Shared translations.
     *
     */
    'title' => config('installer.item_name') . ' Інсталятор',
    'next' => 'Наступний крок',
    'back' => 'Попередній',
    'finish' => 'Встановити',
    'forms' => [
        'errorTitle' => 'Сталися такі помилки:',
    ],

    /*
     *
     * Home page translations.
     *
     */
    'welcome' => [
        'templateTitle' => 'Ласкаво просимо',
        'title'   => config('installer.item_name') . ' Інсталятор',
        'message' => 'Майстер простого встановлення та налаштування.',
        'next'    => 'Перевірити вимоги',
    ],

    /*
     *
     * Requirements page translations.
     *
     */
    'requirements' => [
        'templateTitle' => 'Крок 1 | Вимоги сервера',
        'title' => 'Вимоги сервера',
        'next'    => 'Перевірити дозволи',
    ],

    /*
     *
     * Permissions page translations.
     *
     */
    'permissions' => [
        'templateTitle' => 'Крок 2 | Дозволи',
        'title' => 'Дозволи',
        'next' => 'Налаштувати середовище',
    ],

    /*
     *
     * License page translations.
     *
     */
    'license' => [
        'templateTitle' => 'Крок 3 | Перевірка ліцензії',
        'title' => 'Перевірка ліцензії',
        'next' => 'Підтвердити',
    ],

    /*
     *
     * Environment page translations.
     *
     */
    'environment' => [
        'menu' => [
            'templateTitle' => 'Крок 3 | Налаштування середовища',
            'title' => 'Налаштування середовища',
            'desc' => 'Виберіть, як ви хочете налаштувати файл <code>.env</code> додатку.',
            'wizard-button' => 'Майстер форми',
            'classic-button' => 'Класичний текстовий редактор',
        ],
        'wizard' => [
            'templateTitle' => 'Крок 4 | Налаштування середовища та бази даних',
            'title' => 'Налаштування середовища та бази даних',
            'tabs' => [
                'environment' => 'Середовище',
                'database' => 'База даних',
                'application' => 'Додаток',
            ],
            'form' => [
                'name_required' => 'Необхідно вказати назву середовища.',
                'app_name_label' => 'Назва додатку',
                'app_name_placeholder' => 'Назва додатку',
                'app_environment_label' => 'Середовище додатку',
                'app_environment_label_local' => 'Локальне',
                'app_environment_label_developement' => 'Розробка',
                'app_environment_label_qa' => 'QA',
                'app_environment_label_production' => 'Продукційне',
                'app_environment_label_other' => 'Інше',
                'app_environment_placeholder_other' => 'Введіть середовище...',
                'app_debug_label' => 'Відлагодження додатку',
                'app_debug_label_true' => 'Так',
                'app_debug_label_false' => 'Ні',
                'app_log_level_label' => 'Рівень журналювання',
                'app_log_level_label_debug' => 'відлагодження',
                'app_log_level_label_info' => 'інформація',
                'app_log_level_label_notice' => 'повідомлення',
                'app_log_level_label_warning' => 'попередження',
                'app_log_level_label_error' => 'помилка',
                'app_log_level_label_critical' => 'критичний',
                'app_log_level_label_alert' => 'тривога',
                'app_log_level_label_emergency' => 'аварія',
                'app_url_label' => 'URL додатку',
                'app_url_placeholder' => 'URL додатку',
                'db_connection_failed' => 'Не вдалося підключитися до бази даних.',
                'db_connection_label' => 'Підключення до бази даних',
                'db_connection_label_mysql' => 'mysql',
                'db_connection_label_sqlite' => 'sqlite',
                'db_connection_label_pgsql' => 'pgsql',
                'db_connection_label_sqlsrv' => 'sqlsrv',
                'db_host_label' => 'Хост бази даних',
                'db_host_placeholder' => 'Хост бази даних',
                'db_port_label' => 'Порт бази даних',
                'db_port_placeholder' => 'Порт бази даних',
                'db_name_label' => 'Назва бази даних',
                'db_name_placeholder' => 'Назва бази даних',
                'db_username_label' => 'Ім\'я користувача бази даних',
                'db_username_placeholder' => 'Ім\'я користувача бази даних',
                'db_password_label' => 'Пароль бази даних',
                'db_password_placeholder' => 'Пароль бази даних',

                'app_tabs' => [
                    'more_info' => 'Додаткова інформація',
                    'broadcasting_title' => 'Трансляція, Кешування, Сесія та Черга',
                    'broadcasting_label' => 'Драйвер трансляції',
                    'broadcasting_placeholder' => 'Драйвер трансляції',
                    'cache_label' => 'Драйвер кешу',
                    'cache_placeholder' => 'Драйвер кешу',
                    'session_label' => 'Драйвер сесії',
                    'session_placeholder' => 'Драйвер сесії',
                    'queue_label' => 'Драйвер черги',
                    'queue_placeholder' => 'Драйвер черги',
                    'redis_label' => 'Драйвер Redis',
                    'redis_host' => 'Хост Redis',
                    'redis_password' => 'Пароль Redis',
                    'redis_port' => 'Порт Redis',

                    'mail_label' => 'Пошта',
                    'mail_driver_label' => 'Драйвер пошти',
                    'mail_driver_placeholder' => 'Драйвер пошти',
                    'mail_host_label' => 'Поштовий хост',
                    'mail_host_placeholder' => 'Поштовий хост',
                    'mail_port_label' => 'Поштовий порт',
                    'mail_port_placeholder' => 'Поштовий порт',
                    'mail_username_label' => 'Ім\'я користувача пошти',
                    'mail_username_placeholder' => 'Ім\'я користувача пошти',
                    'mail_password_label' => 'Пароль пошти',
                    'mail_password_placeholder' => 'Пароль пошти',
                    'mail_encryption_label' => 'Шифрування пошти',
                    'mail_encryption_placeholder' => 'Шифрування пошти',

                    'pusher_label' => 'Pusher',
                    'pusher_app_id_label' => 'Pusher App ID',
                    'pusher_app_id_palceholder' => 'Pusher App ID',
                    'pusher_app_key_label' => 'Pusher App Key',
                    'pusher_app_key_palceholder' => 'Pusher App Key',
                    'pusher_app_secret_label' => 'Pusher App Secret',
                    'pusher_app_secret_palceholder' => 'Pusher App Secret',
                ],
                'buttons' => [
                    'setup_database' => 'Налаштувати БД та середовище',
                    'setup_application' => 'Налаштувати додаток',
                    'install' => 'Встановити',
                ],
            ],
        ],
        'classic' => [
            'templateTitle' => 'Крок 3 | Налаштування середовища | Класичний редактор',
            'title' => 'Класичний редактор середовища',
            'save' => 'Зберегти .env',
            'back' => 'Використати майстер',
            'install' => 'Зберегти та встановити',
        ],
        'success' => 'Налаштування файлу .env збережено.',
        'errors' => 'Не вдалося зберегти файл .env. Створіть його вручну.',
    ],

    'install' => 'Встановити',

    /*
     *
     * Installed Log translations.
     *
     */
    'installed' => [
        'success_log_message' => config('installer.item_name') . ' успішно ВСТАНОВЛЕНО на ',
    ],

    /*
     *
     * Final page translations.
     *
     */
    'final' => [
        'title' => 'Встановлення завершено',
        'templateTitle' => 'Встановлення завершено',
        'finished' => 'Додаток успішно встановлено.',
        'migration' => 'Вивід консолі міграції та наповнення:',
        'console' => 'Вивід консолі додатку:',
        'log' => 'Запис журналу встановлення:',
        'env' => 'Фінальний файл .env:',
        'exit' => 'Натисніть тут, щоб вийти',
    ],

    /*
     *
     * Update specific translations
     *
     */
    'updater' => [
        /*
         *
         * Shared translations.
         *
         */
        'title' => 'Оновлювач Laravel',

        /*
         *
         * Welcome page translations for update feature.
         *
         */
        'welcome' => [
            'title'   => 'Ласкаво просимо до оновлювача',
            'message' => 'Ласкаво просимо до майстра оновлення.',
        ],

        /*
         *
         * Welcome page translations for update feature.
         *
         */
        'overview' => [
            'title'   => 'Огляд',
            'message' => 'Є 1 оновлення.|Є :number оновлень.',
            'install_updates' => 'Встановити оновлення',
        ],

        /*
         *
         * Final page translations.
         *
         */
        'final' => [
            'title' => 'Завершено',
            'finished' => 'Базу даних додатку успішно оновлено.',
            'exit' => 'Натисніть тут, щоб вийти',
        ],

        'log' => [
            'success_message' => 'Laravel Installer успішно ОНОВЛЕНО на ',
        ],
    ],
];