# AGENTS.md

- используй memories.sh для сохранения важных решений и фактов между сессиями: `memories add --decision "..."` или `memories add --fact "..."`
- в начале сессии выполняй `memories recall --json` для загрузки контекста
- все запросы консоли на локальном сервере делай в докер окружении
- Python скрипты создавай в `/Users/admin/Documents/dev/profiexp.com/scripts/`
- проверяй файлы на наличие ошибок docker compose exec -T web php -l ...
- сейчас активна тема v2 все правки делай там

## Тестирование

- используй laravel tinker для тестирования отладки получения данных например: docker compose exec -T web php ... 
- создавай тесты при добавлении новых методов и функций php

- для получения данных страницы предпочтительно используй curl и не вызывай браузер каждый раз только если пользователь прямо об этом попросит или возникнет сильная необходимость 

### Demo credentials

- admin
  путь до админки /admin/ admin admin

- user 
  demo0 demo0123456

- vendor
  vendor1 vendor123456

## Локализация (переводы)

- дашборд поставщика (vendor dashboard) использует файлы `admin_*.json` (например `admin_ru.json`, `admin_tr.json`)
- публичная часть сайта использует `ru.json`, `tr.json` и т.д.
- это поведение определяется в middleware `VendorLocal` (/app/app/Http/Middleware/VendorLocal.php): vendor->lang_code = 'admin_ru'
- поэтому переводы для кабинета поставщика добавляй ТОЛЬКО в `admin_*.json`, иначе они не будут отображаться

## Деплой

- Инструкцию из [DEPLOY.md](DEPLOY.md) читать и выполнять только при явном запросе пользователя на деплой.
- В обычных задачах деплойные команды, production-доступы и deploy workflow не применять.
