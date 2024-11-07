#!/bin/sh
set -e

# Remplacer les variables d'environnement dans les templates
envsubst '\$SERVER_NAME' < /etc/nginx/templates/prestashop.conf > /etc/nginx/conf.d/prestashop.conf

# Définir les permissions pour Nginx
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
chmod -R 755 /var/www/html/*

# Lancer Nginx
exec "$@"