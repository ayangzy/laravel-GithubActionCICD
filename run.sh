#!/bin/sh

set -e

php artisan config:clear
php artisan migrate --force --seed
php artisan clear-compiled
php artisan auth:clear-resets
php artisan optimize:clear
php artisan config:cache
php artisan view:cache
php artisan route:cache
composer dump-autoload

php artisan serve --host=0.0.0.0 --port=9000