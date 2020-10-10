#!/bin/sh

echo "$CRON_INTERVAL sh /backup  > /dev/stdout 2>&1
# This extra line makes it a valid cron" > crontab.txt

crontab /crontab.txt

# start cron
/usr/sbin/crond -f -l 8