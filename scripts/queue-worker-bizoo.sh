#!/bin/sh
cd /var/www/bizoo_es_usr/data/www/bizoo.es
exec /usr/bin/php8.3 artisan queue:work --stop-when-empty
