#!/bin/bash

# Initialize the data dir if there's a new volume here.
if [ ! "$(ls -A /var/www/html/data)" ]; then
    echo "default initializing /var/www/html/data"
    cp -rT /var/www/html/data.default/ /var/www/html/data
fi

# Run the "real" entrypoint.
exec docker-php-entrypoint apache2-foreground
