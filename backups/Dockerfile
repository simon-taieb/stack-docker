FROM ubuntu:20.04

# Installer les dépendances
RUN apt-get update && \
    apt-get install -y cron mariadb-client rsyslog && \
    rm -rf /var/lib/apt/lists/*

# Copier le script de sauvegarde
COPY backup.sh /usr/local/bin/backup.sh
RUN chmod +x /usr/local/bin/backup.sh

# Copier le fichier crontab
COPY crontab /etc/cron.d/backup-cron
RUN chmod 0644 /etc/cron.d/backup-cron

# Configurer rsyslog pour la journalisation de cron
RUN sed -i 's/#cron./cron./' /etc/rsyslog.d/50-default.conf

# Créer les répertoires nécessaires
RUN mkdir -p /backups /var/log/cron

# Démarrer rsyslog et cron
CMD ["sh", "-c", "service rsyslog start && cron -f"]