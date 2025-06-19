#!/bin/bash

# Log output to a file for debugging
#exec &> /workspace/post-create.log

echo "Starting post-create setup at $(date)"
echo "Setting permissions for /workspace/var/cache and /workspace/var/log"
chown -R www-data:www-data /workspace/var/cache /workspace/var/log || echo "Error: Failed to set permissions"
chmod -R 775 /workspace/var/cache /workspace/var/log || echo "Error: Failed to set chmod"
# Start PHP-FPM
#service php8.2-fpm start || echo "Error: Failed to start PHP-FPM"

#chmod +x package.json composer.json .gitignore || echo "Warning: Failed to set permissions on package.json, composer.json, or .gitignore"

# Install Node.js dependencies
npm install || echo "Warning: npm install failed, continuing..."
echo "Node.js dependencies installed."

# Install PHP dependencies
composer install --no-interaction || echo "Warning: Composer install failed, continuing..."
echo "Composer dependencies installed."

# Clear Symfony cache
php bin/console cache:clear || echo "Warning: Cache clear failed, continuing..."
echo "Symfony cache cleared."

# Ensure permissions for Caddy and PHP-FPM
#chown -R www-data:www-data /workspace/var/cache /workspace/var/log
#chmod -R 775 /workspace/var/cache /workspace/var/log

# Wait for MariaDB to be ready
MAX_ATTEMPTS=30
ATTEMPT=1
until mysql -h db -u mariadb -pmariadb mariadb -e "SELECT 1" 2>/dev/null; do
    echo "Waiting for MariaDB to be ready... (Attempt $ATTEMPT/$MAX_ATTEMPTS)"
    if [ $ATTEMPT -ge $MAX_ATTEMPTS ]; then
        echo "Error: MariaDB did not become ready in time. Exiting."
        exit 1
    fi
    sleep 2
    ((ATTEMPT++))
done
echo "MariaDB is ready!"

echo "Post-create setup completed at $(date)"
echo "You are ready! Open a terminal, type \"npx encore dev\" to build your assets with a watcher"
exit 0
