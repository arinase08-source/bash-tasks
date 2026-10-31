#!/bin/bash

FILE="/tmp/ready"
TIME=30
WAITED=0

while [ "$WAITED" -lt "$TIME" ]
do
    if [ -f "$FILE" ]; then
        echo "Файл $FILE появился (ждали ${WAITED}s)"
        exit 0
    fi

    sleep 2
    WAITED=$((WAITED + 2))
done

if [ -f "$FILE" ]; then
    echo "Файл $FILE появился (ждали ${WAITED}s)"
    exit 0
fi

echo "Таймаут: файл $FILE не появился" >&2
exit 1
