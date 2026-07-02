#!/bin/bash
set -e
echo "🚀 Starting XPlusHost Engine..."
mkdir -p /sites /var/log/nginx /var/log/php-fpm /etc/traefik/dynamic/sites
chown -R www-data:www-data /sites
chmod -R 755 /sites
nginx -t
exec /usr/bin/supervisord -c /etc/supervisor/supervisord.conf -n
