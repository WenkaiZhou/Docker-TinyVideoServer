#!/bin/bash

# terminate on errors
set -e

LOGS_FILE="/var/www/html/storage/logs"

# Check if volume is empty
if [ ! -e $LOGS_FILE ]; then
    echo 'Setting up tiny video server volume'
    mkdir -p $LOGS_FILE
fi

# Make sure the html files needed by the processes are accessable when they run under the www-data user
chown -R www-data:www-data /var/www/html/
chmod -R 755 /var/www/html/

exec "$@"