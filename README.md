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
