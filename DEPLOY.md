# Deploy instructions

Использовать этот файл только при явном запросе пользователя на деплой.

## Общие правила

- Production работает на обычном PHP/FastPanel, не в Docker.
- Порядок действий: проверить ветку и изменения → сделать `git commit` → выполнить `git push` → проверить, что production-клон видит тот же commit → выполнить деплой.
- Перед деплоем сделать DB backup командой `php artisan backup:run --only-db`.
- Не деплоить неприкоммиченные или непушенные изменения.
- Сохранять `.env`, пользовательские uploads и production-only `queue-worker.sh`.
- После синхронизации выполнить `composer install`, `php artisan migrate --force`, `php artisan optimize:clear`, `php artisan config:cache` и `php artisan view:cache` от пользователя сайта.

## profiexp.com

- Ветка: `main`.
- Production: `/var/www/profiexp_com_usr/data/www/profiexp.com`.
- Deploy script: `/var/www/profiexp_com_usr/data/deploy.sh`.
- Worker `queue-worker.sh` хранится только на production и исключён из rsync.

## bizoo.es

- Ветка: `spain`.
- Production: `/var/www/bizoo_es_usr/data/www/bizoo.es`.
- Основной deploy script: `/root/deploy-bizoo.sh`.
- Копия script: `/root/bizoo-repo/scripts/deploy-bizoo.sh`.
- Перед запуском проверить, что серверный `origin/spain` совпадает с нужным локальным commit; если нет — синхронизировать локальную ветку напрямую.
- Сохранять `vendor`, `node_modules`, `public/assets`, `public/storage`, `public/hot` и `queue-worker.sh`.
- После деплоя проверить сайт curl-запросом и выполнить `city-categories:translate --batch=1`; worker запускается cron из `queue-worker.sh`.
