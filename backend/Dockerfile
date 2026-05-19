FROM php:8.4-cli

WORKDIR /var/www

# -----------------------------
# Dépendances système
# -----------------------------
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    zip \
    unzip \
    curl \
    git \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# -----------------------------
# Extensions PHP
# -----------------------------
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        pdo_mysql \
        mbstring \
        exif \
        pcntl \
        bcmath \
        gd \
        zip

# -----------------------------
# Composer
# -----------------------------
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# -----------------------------
# Copie du projet
# -----------------------------
COPY . .

# -----------------------------
# Fix Laravel permissions BEFORE composer install
# -----------------------------
RUN mkdir -p bootstrap/cache storage \
    && chmod -R 777 bootstrap/cache storage

# -----------------------------
# Install dependencies
# -----------------------------
RUN composer install --no-interaction --optimize-autoloader --no-dev

# -----------------------------
# Permissions propres (après install)
# -----------------------------
RUN chown -R www-data:www-data /var/www \
    && chmod -R 775 storage bootstrap/cache

# -----------------------------
# Entrypoint
# -----------------------------
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# -----------------------------
# Port Laravel
# -----------------------------
EXPOSE 8000

ENTRYPOINT ["docker-entrypoint.sh"]
