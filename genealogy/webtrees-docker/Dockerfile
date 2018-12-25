FROM php:apache

RUN apt-get update

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev && \
    docker-php-source extract && \
    docker-php-ext-install pdo_mysql gd && \
    docker-php-source delete

RUN apt-get install -y unzip && \
    curl -LO https://github.com/fisharebest/webtrees/releases/download/1.7.12/webtrees-1.7.12.zip && \
    unzip *.zip && rm *.zip && \
    mv webtrees/* . && rmdir webtrees && \
    chown -R www-data.www-data . && \
    mv data data.default

RUN touch /var/www/html/healthz && \
    chown www-data.www-data /var/www/html/healthz

# To preserve state across container restarts, users should mount a volume
# at /var/www/html/data

COPY entrypoint.sh /
ENTRYPOINT /entrypoint.sh
