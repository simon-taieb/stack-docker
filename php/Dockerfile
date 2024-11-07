FROM php:8.0-fpm

# Ajouter wget et gnupg, puis ajouter le dépôt Sury pour PHP 8.0 et ses extensions
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    wget \
    gnupg \
    && wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - \
    && echo "deb https://packages.sury.org/php/ bullseye main" | tee /etc/apt/sources.list.d/php.list

# Installer les dépendances nécessaires, y compris libicu-dev
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install -j$(nproc) zip \
    && docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql mbstring exif pcntl \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# Définir le répertoire de travail
WORKDIR /var/www/html

# Copier le contenu de l'application
COPY . /var/www/html

# Installer Composer
#COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Installer les dépendances PHP via Composer
#RUN composer install

# Définir les permissions
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 9000

CMD ["php-fpm"]