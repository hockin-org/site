FROM php:apache as prep

RUN apt-get update

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libicu-dev \
        libzip-dev

RUN docker-php-source extract && \
    docker-php-ext-configure gd --with-jpeg --with-freetype && \
    docker-php-ext-install pdo_mysql gd exif intl zip && \
    docker-php-source delete

RUN apt-get install -y unzip && \
    curl -LO https://github.com/fisharebest/webtrees/releases/download/2.0.16/webtrees-2.0.16.zip && \
    unzip *.zip && rm *.zip && \
    mv webtrees/* . && rmdir webtrees && \
    chown -R www-data.www-data . && \
    mv data data.default

RUN touch /var/www/html/healthz && \
    chown www-data.www-data /var/www/html/healthz

RUN apt-get -y autoremove
RUN rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /
COPY apache_prefork.conf /etc/apache2/mods-enabled/mpm_prefork.conf

###############################################################################

FROM scratch
COPY --from=prep / /

# To preserve state across container restarts, users should mount a volume
# at /var/www/html/data

ENTRYPOINT /entrypoint.sh
