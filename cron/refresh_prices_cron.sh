#!/bin/bash

# cron/refresh_prices_cron.sh

# URL du script cron de PrestaShop
CRON_URL="http://prestashop_nginx/modules/refreshprices/cron.php?GUxM7yuz43D5nhi2CN89XX"

# Exécuter la requête CURL
curl -s "${CRON_URL}"