#!/bin/bash

# scripts/pre_deploy.sh

# Variables d'environnement
DB_HOST="db"
DB_USER="${MYSQL_USER}"
DB_PASSWORD="${MYSQL_PASSWORD}"
DB_NAME="${MYSQL_DATABASE}"
BACKUP_DIR="/backup"
LATEST_BACKUP=$(ls -t "${BACKUP_DIR}"/*.sql 2>/dev/null | head -1)
SHOP_DOMAIN="${DOMAIN_NAME}"

# Vérifier la connexion à la base de données
echo "Vérification de la connexion à la base de données..."
mysqladmin ping -h "${DB_HOST}" -u "${DB_USER}" -p"${DB_PASSWORD}" --silent
if [ $? -ne 0 ]; then
    echo "Impossible de se connecter à la base de données ${DB_HOST}."
    exit 1
fi

# Vérifier si la base de données est vide
DB_COUNT=$(mysql -h "${DB_HOST}" -u "${DB_USER}" -p"${DB_PASSWORD}" -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${DB_NAME}';" | tail -n1)

if [ "${DB_COUNT}" -eq 0 ]; then
    echo "La base de données est vide. Restauration à partir de la dernière sauvegarde."
    if [ -z "${LATEST_BACKUP}" ]; then
        echo "Aucune sauvegarde disponible."
        exit 1
    fi
    mysql -h "${DB_HOST}" -u "${DB_USER}" -p"${DB_PASSWORD}" "${DB_NAME}" < "${LATEST_BACKUP}"
    if [ $? -eq 0 ]; then
        echo "Restauration réussie à partir de ${LATEST_BACKUP}"
    else
        echo "Échec de la restauration."
        exit 1
    fi
else
    echo "La base de données contient des données."
fi

