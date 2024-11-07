#!/bin/bash

# deploy.sh

# Vérifie si un argument est passé (--prod ou --dev)
if [ "$1" == "--prod" ]; then
    ENV_FILE=".env.prod"
elif [ "$1" == "--dev" ]; then
    ENV_FILE=".env.dev"
else
    echo "Usage: $0 [--prod | --dev]"
    exit 1
fi

echo "Utilisation du fichier d'environnement : $ENV_FILE"

# Construire et démarrer la stack avec le bon fichier d'environnement
docker compose --env-file $ENV_FILE up -d --build

# Attendre que le conteneur db soit prêt
echo "Attente que MariaDB soit prêt..."
sleep 30 # Ajustez le temps en fonction de votre configuration

# Exécuter le script de pré-déploiement avec le bon environnement
docker-compose --env-file $ENV_FILE run --rm pre_deploy