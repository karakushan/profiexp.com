#!/bin/sh
set -e

cd /app

mkdir -p \
  bootstrap/cache \
  storage/framework/cache \
  storage/framework/sessions \
  storage/framework/testing \
  storage/framework/views \
  storage/logs \
  public/assets/file \
  public/assets/img \
  public/assets/front/invoices

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
fi

if [ ! -f vendor/autoload.php ]; then
  composer install --no-interaction --prefer-dist --optimize-autoloader
fi

chmod -R ug+rwX storage bootstrap/cache public/assets public/pgw || true
chown -R application:application storage bootstrap/cache public/assets public/pgw || true

exec "$@"
