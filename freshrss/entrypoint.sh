#!/bin/bash

set -e
. /etc/apache2/envvars
UPDATE_INTERVAL=${UPDATE_INTERVAL:-1200}

# Background updater
nohup bash -c '
    while true; do
        php /var/www/FreshRSS/app/actualize_script.php > /dev/null 2>&1
        echo "Feed update completed at $(date)"
        sleep '"$UPDATE_INTERVAL"'
    done
' >> /tmp/freshrss-updater.log 2>&1 &

# Start Apache
if [[ "$OIDC_ENABLED" == "true" ]]; then
    exec apache2 -DFOREGROUND -DOIDC_ENABLED
else
    exec apache2 -DFOREGROUND
fi