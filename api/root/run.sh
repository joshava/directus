#!/bin/bash

set -e;

db_is_up() {
    nc -z "${DATABASE_HOST:-database}" "${DATABASE_PORT:-3306}" >/dev/null 2>&1
}

RETRY_COUNT=0
RETRIES=${DATABASE_WAIT_TIMEOUT:-30}
until db_is_up || [ $RETRY_COUNT -eq $RETRIES ]
do
    echo "!"
    sleep 1s
    RETRY_COUNT=$((RETRY_COUNT+1))
done

if [ $RETRY_COUNT -eq $RETRIES ]
then
    echo "exit"
    exit 1
fi

php /bootstrap.php

apache2-foreground
