FROM php:apache

RUN apt-get update

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev && \
    docker-php-source extract && \
    docker-php-ext-install pdo_mysql gd && \
    docker-php-source delete

RUN apt-get install -y unzip && \
    curl -LO https://github.com/fisharebest/webtrees/releases/download/1.7.9/webtrees-1.7.9.zip && \
    unzip *.zip && rm *.zip && \
    mv webtrees/* . && rmdir webtrees && \
    chown -R www-data.www-data . && \
    mv data data.default

VOLUME /var/www/html/data

COPY entrypoint.sh /
ENTRYPOINT /entrypoint.sh
