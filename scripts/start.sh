#! /bin/sh

set -e

if [ "${REMOTE_POSTGRES_DB}" = "**None**" ]; then
  echo "You need to set the REMOTE_POSTGRES_DB  environment variable."
  exit 1
fi

if [ "${REMOTE_POSTGRES_HOST}" = "**None**" ]; then
  echo "You need to set the REMOTE_POSTGRES_HOST environment variable."
  exit 1
fi

if [ "${REMOTE_POSTGRES_USER}" = "**None**" ]; then
  echo "You need to set the REMOTE_POSTGRES_USER  environment variable."
  exit 1
fi

if [ "${REMOTE_POSTGRES_PASSWORD}" = "**None**" ]; then
  echo "You need to set the REMOTE_POSTGRES_PASSWORD  environment variable."
  exit 1
fi

if [ "${AWS_ACCESS_KEY_ID}" = "**None**" ]; then
  echo "You need to set the AWS_ACCESS_KEY_ID  environment variable."
  exit 1
fi

if [ "${AWS_SECRET_ACCESS_KEY}" = "**None**" ]; then
  echo "You need to set the AWS_SECRET_ACCESS_KEY  environment variable."
  exit 1
fi

if [ "${POSTGRES_BACKUP_BUCKET}" = "**None**" ]; then
  echo "You need to set the POSTGRES_BACKUP_BUCKET  environment variable."
  exit 1
fi


if [ $REPLICATE ] 
then
  echo "REPLICATING DB"
  sh /replicate
else
echo "RUNNING PERIODIC BACKUPS"
sh /backup
fi


