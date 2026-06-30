# Bulistio Docker Setup

1. Start the environment:

```bash
docker compose up -d --build
```

2. Open the installer:

```text
http://localhost:8080
```

3. Use these database values in the Bulistio installer:

```text
Database Host: db
Database Port: 3306
Database Name: bulistio
Database Username: bulistio
Database Password: bulistio
```

4. Complete the license verification step with your Envato email, username, and purchase code.

5. After installation, the cron container already runs the documented daily job for:

```text
wget {your_website_url}/subcheck
```

Services:

- Website: `http://localhost:8080`
- MariaDB: `127.0.0.1:3307`

Notes:

- The installer SQL dump was preconfigured with `theme_version = 2`, so Bulistio will start on the same frontend theme family as the demo `?theme=two`.

## Production deploy (FastPanel + exim)

1. Commit & push changes to `main` on GitHub
2. SSH into server and run deploy:
   ```bash
   ssh profiexp_com_usr@13.140.175.53 'bash ~/deploy.sh'
   ```

The `~/deploy.sh` script does:
- `git pull` in `~/profiexp-repo/`
- rsync `app/` → web root (excludes `.env`, `storage/`, `vendor/`, `node_modules/`, `public/storage`, `queue-worker.sh`)
- `composer install --optimize-autoloader`
- `artisan optimize:clear && artisan config:cache && artisan route:cache && artisan view:cache`

**Important:**
- `.env` on the server is **never** overwritten (excluded from rsync)
- `queue-worker.sh` is also excluded
- If you change `config/mail.php`, update both locally (`app/config/mail.php`) and on the server manually
- SMTP settings for `BasicMailer` (registration, orders) are stored in the DB (`basic_settings`), not in `.env`
