FROM php:8.0-fpm-alpine


RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin --filename=composer

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apk add --no-cache \
    bash \
    git \
    openssh \
    openssl \
    supervisor

RUN docker-php-ext-install pdo_mysql

WORKDIR /var/www/html

COPY . .

RUN composer install --no-interaction --no-scripts --no-progress --prefer-dist --no-dev && \
    composer dump-autoload --no-interaction --optimize

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


RUN php artisan serve --host=0.0.0.0 --port=9000

EXPOSE 9000

#CMD bash -C './run.sh';'bash'

#CMD /bin/sh -C "./run.sh"; /usr/bin/supervisord -n -c /var/www/html/supervisord.conf

