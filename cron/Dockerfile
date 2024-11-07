# cron/Dockerfile

FROM ubuntu:20.04

# Installer les dépendances nécessaires
RUN apt-get update && \
    apt-get install -y cron curl && \
    rm -rf /var/lib/apt/lists/*

# Copier le script de cron
COPY refresh_prices_cron.sh /usr/local/bin/refresh_prices_cron.sh
RUN chmod +x /usr/local/bin/refresh_prices_cron.sh

# Copier le fichier crontab
COPY crontab /etc/cron.d/refresh-prices-cron

# Définir les permissions du fichier crontab
RUN chmod 0644 /etc/cron.d/refresh-prices-cron

# Créer le répertoire de logs
RUN mkdir -p /var/log

# Appliquer le crontab
# Ne pas utiliser la commande `crontab` ici car les fichiers dans /etc/cron.d/ sont automatiquement pris en compte par cron

# Lancer cron en avant-plan
CMD ["cron", "-f"]