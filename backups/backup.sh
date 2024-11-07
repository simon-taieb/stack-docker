#!/bin/bash

# Variables d'environnement
DB_HOST="${DB_HOST}"
DB_USER="${MYSQL_USER}"
DB_PASSWORD="${MYSQL_PASSWORD}"
DB_NAME="${MYSQL_DATABASE}"
BACKUP_DIR="/backups"
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="${BACKUP_DIR}/backup_${DATE}.sql"

# Effectuer la sauvegarde
echo "Démarrage de la sauvegarde de la base de données..."

/usr/bin/mysqldump -h "${DB_HOST}" -u "${DB_USER}" -p"${DB_PASSWORD}" "${DB_NAME}" > "${BACKUP_FILE}"

if [ $? -eq 0 ]; then
    echo "Sauvegarde réussie : ${BACKUP_FILE}"
else
    echo "Échec de la sauvegarde."
    exit 1
fi