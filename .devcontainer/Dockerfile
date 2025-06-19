FROM mcr.microsoft.com/devcontainers/php:1-8.3-bullseye

# Install MariaDB client
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y mariadb-client git curl libpng-dev libonig-dev libxml2-dev zip unzip libicu-dev \
    debian-keyring debian-archive-keyring apt-transport-https \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*
    
# Install Caddy
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg \
    && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list \
    && apt-get update \
    && apt-get install -y caddy \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install php-mysql driver
RUN docker-php-ext-install mysqli pdo pdo_mysql mbstring gd intl

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Symfony CLI
RUN curl -1sLf 'https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh' | sudo -E bash 
RUN sudo apt install symfony-cli

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g npm@latest \
    && rm -rf /var/lib/apt/lists/*

# Create directories for certs, Caddy logs and Symfony
RUN mkdir -p RUN mkdir -p /etc/caddy/certs /workspace/var/log \
    && mkdir -p /workspace/var/cache /workspace/var/log/caddy

# Copy Caddy configuration
COPY ./caddy/Caddyfile /etc/caddy/Caddyfile
COPY ./certs/localhost.crt /etc/caddy/certs/localhost.crt
COPY ./certs/localhost.key /etc/caddy/certs/localhost.key

# Copy Symfony files
COPY ./symfony/composer.json /workspace/composer.json
COPY ./symfony/package.json /workspace/package.json
COPY ./symfony/.gitignore /workspace/.gitignore

# Copy and make post-create script executable
COPY ./post-create.sh /workspace/post-create.sh

RUN chown -R www-data:www-data /workspace/var && chmod -R 775  /workspace/var
RUN chown -R www-data:www-data /etc/caddy/certs && chmod -R 644 /etc/caddy/certs
RUN chmod +x /workspace/post-create.sh /workspace/package.json /workspace/composer.json

# Expose ports for Caddy
EXPOSE 8080 443
