FROM php:7.4-fpm-alpine

RUN apk update \
 && apk add --no-cache $PHPIZE_DEPS \
    git \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install opcache pdo_mysql mysqli
RUN docker-php-ext-enable opcache

# Install Xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

# Download & install latest Composer
RUN curl --insecure https://getcomposer.org/composer.phar -o /usr/bin/composer && chmod +x /usr/bin/composer

# Freezes Composer version
RUN composer self-update 2.0.7

WORKDIR /var/www/app