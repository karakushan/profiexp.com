#!/bin/bash
set -e

REPO_DIR="$HOME/profiexp-repo"
WEB_ROOT="/var/www/profiexp_com_usr/data/www/profiexp.com"
EXCLUDES=".env .env.backup storage vendor node_modules public/storage public/hot bootstrap/cache/*.php"

echo "=== Pulling latest from git ==="
cd "$REPO_DIR"
git fetch origin
git reset --hard origin/main

echo "=== Syncing to web root ==="
RSYNC_EXCLUDES=""
for item in $EXCLUDES; do
    RSYNC_EXCLUDES="$RSYNC_EXCLUDES --exclude=/$item"
done
rsync -a --delete $RSYNC_EXCLUDES "$REPO_DIR/app/" "$WEB_ROOT/"

echo "=== Setting permissions ==="
chmod -R 755 "$WEB_ROOT"
chmod -R 775 "$WEB_ROOT/storage" "$WEB_ROOT/bootstrap/cache" 2>/dev/null || true

echo "=== Installing composer dependencies ==="
cd "$WEB_ROOT"
composer install --no-dev --optimize-autoloader 2>/dev/null || composer install --optimize-autoloader

echo "=== Laravel cache clear ==="
php artisan optimize:clear 2>/dev/null || true
php artisan config:cache 2>/dev/null || true
php artisan route:cache 2>/dev/null || true
php artisan view:cache 2>/dev/null || true

echo "=== Deploy complete ==="
