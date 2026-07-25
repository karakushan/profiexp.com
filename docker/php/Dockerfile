FROM webdevops/php-apache:8.3

RUN apt-get update \
    && apt-get install -y --no-install-recommends mariadb-client \
    && rm -rf /var/lib/apt/lists/*

COPY docker/php/entrypoint.sh /usr/local/bin/app-entrypoint
COPY docker/php/cron-laravel /etc/cron.d/laravel
COPY docker/php/supervisor-queue.conf /opt/docker/etc/supervisor.d/queue.conf

RUN chmod +x /usr/local/bin/app-entrypoint && chmod 0644 /etc/cron.d/laravel && crontab /etc/cron.d/laravel -u application || true

WORKDIR /app
