#!/bin/bash

if [ "$1" == "dev" ]; then
    echo "Lancement de l'environnement de développement..."
    docker-compose --env-file .env.dev -f docker-compose.yml -f docker-compose.dev.yml up -d
elif [ "$1" == "prod" ]; then
    echo "Lancement de l'environnement de production..."
    docker-compose --env-file .env.prod -f docker-compose.yml -f docker-compose.prod.yml up -d
else
    echo "Usage: ./start.sh [dev|prod]"
fi