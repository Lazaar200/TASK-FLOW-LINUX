#!/bin/bash
set +e

# Copier .env si pas présent
if [ ! -f /var/www/.env ]; then
    cp /var/www/.env.example /var/www/.env
fi

# Générer la clé si vide
php artisan key:generate --no-interaction --force

# Attendre MySQL
echo "Attente de MySQL..."
until php -r "new PDO('mysql:host='.\$_ENV['DB_HOST'].';port='.\$_ENV['DB_PORT'], \$_ENV['DB_USERNAME'], \$_ENV['DB_PASSWORD']);" 2>/dev/null; do
    sleep 2
done
echo "MySQL prêt ✅"

# Migrations
php artisan migrate --force --no-interaction 2>/dev/null || true

# Lancer Laravel
exec php artisan serve --host=0.0.0.0 --port=8000

