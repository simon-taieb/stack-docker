FROM nginx:latest

# Installer gettext pour utiliser envsubst
RUN apt-get update && apt-get install -y gettext-base

# Supprimer la configuration par défaut de Nginx
RUN rm /etc/nginx/conf.d/default.conf

# Copier le template de configuration Nginx
COPY conf.d /etc/nginx/templates

# Remplacer le script d'entrée par défaut
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]