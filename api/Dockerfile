FROM php:7-apache

ARG VERSION=v2.0.13

RUN sed -i 's#/var/www/html#'/var/www/html/public'#g' /etc/apache2/sites-available/000-default.conf

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    zip \
    libpng-dev \
    libmagickwand-dev \
    netcat && \
    git clone -b $VERSION https://github.com/directus/api.git /var/www/html && \
    pecl install imagick && \
    docker-php-ext-enable imagick && \
    rm -r /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install pdo_mysql mbstring gd

COPY root/ /

RUN chown -R www-data:www-data /var/www/html && \
    chmod +x /run.sh

RUN a2enmod rewrite

CMD ["/run.sh"]
