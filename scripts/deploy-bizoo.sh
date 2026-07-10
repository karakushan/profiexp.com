#!/bin/bash
set -euo pipefail

REPO_DIR="$HOME/bizoo-repo"
WEB_ROOT="/var/www/bizoo_es_usr/data/www/bizoo.es"
BRANCH="spain"

cd "$REPO_DIR"
git fetch origin "$BRANCH"
git reset --hard "origin/$BRANCH"

rsync -a --delete \
  --exclude='/.env' \
  --exclude='/.env.backup' \
  --exclude='/storage/' \
  --exclude='/vendor/' \
  --exclude='/node_modules/' \
  --exclude='/public/assets/' \
  --exclude='/public/storage' \
  --exclude='/public/hot' \
  --exclude='/bootstrap/cache/*.php' \
  --exclude='/queue-worker.sh' \
  "$REPO_DIR/app/" "$WEB_ROOT/"

# Deploy tracked frontend assets while preserving uploaded files under
# public/assets/img and public/assets/storage.
rsync -a "$REPO_DIR/app/public/assets/front/css/" "$WEB_ROOT/public/assets/front/css/"
rsync -a "$REPO_DIR/app/public/assets/front/js/" "$WEB_ROOT/public/assets/front/js/"
rsync -a "$REPO_DIR/app/public/assets/admin/js/" "$WEB_ROOT/public/assets/admin/js/"

chown -R bizoo_es_usr:bizoo_es_usr "$WEB_ROOT"
chmod -R 775 "$WEB_ROOT/storage" "$WEB_ROOT/bootstrap/cache"

cd "$WEB_ROOT"
sudo -u bizoo_es_usr composer install --no-dev --optimize-autoloader --no-scripts
sudo -u bizoo_es_usr php artisan migrate --force
sudo -u bizoo_es_usr php artisan optimize:clear
sudo -u bizoo_es_usr php artisan package:discover --ansi
sudo -u bizoo_es_usr php artisan config:cache
sudo -u bizoo_es_usr php artisan view:cache

echo "Deploy complete: $BRANCH -> $WEB_ROOT"
