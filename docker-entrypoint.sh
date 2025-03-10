#!/bin/bash

TZ=${TZ:-Etc/UTC}
CRON_TIMING=${CRON_TIMING:-'* * * * *'}
APACHE_RUN_USER=${APACHE_RUN_USER:-'www-data'}
APACHE_RUN_GROUP=${APACHE_RUN_GROUP:-'www-data'}

echo --------------------------------------------------
echo "Setting up Timzone: \"${TZ}\""
echo --------------------------------------------------
echo $TZ | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata

set -ex

# Reload Cron
echo "${CRON_TIMING} php /var/www/html/front/cron.php &>/dev/null" | crontab -u ${APACHE_RUN_USER} -
/etc/init.d/cron reload
/etc/init.d/cron restart

exec "$@"
