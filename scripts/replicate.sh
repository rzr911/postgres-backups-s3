#! /bin/sh

set -e

if [ "${RESTORE_POSTGRES_DB}" = "**None**" ]; then
  echo "You need to set the RESTORE_POSTGRES_DB  environment variable."
  exit 1
fi

if [ "${RESTORE_POSTGRES_HOST}" = "**None**" ]; then
  echo "You need to set the RESTORE_POSTGRES_HOST environment variable."
  exit 1
fi

if [ "${RESTORE_POSTGRES_USER}" = "**None**" ]; then
  echo "You need to set the RESTORE_POSTGRES_USER  environment variable."
  exit 1
fi

if [ "${RESTORE_POSTGRES_PASSWORD}" = "**None**" ]; then
  echo "You need to set the RESTORE_POSTGRES_PASSWORD  environment variable."
  exit 1
fi

echo "Creating dump of ${REMOTE_POSTGRES_DB} database from ${REMOTE_POSTGRES_HOST} ..."
DATE=`date +%Y-%m-%d`
BACKUP_FILE=${REMOTE_POSTGRES_DB}-`date +%Y-%m-%d-%H%M%S`.sql
PGPASSWORD=${REMOTE_POSTGRES_PASSWORD} pg_dump -h ${REMOTE_POSTGRES_HOST} -U ${REMOTE_POSTGRES_USER} -d ${REMOTE_POSTGRES_DB} > ./${BACKUP_FILE}

echo "RESTORING DUMP"
PGPASSWORD=${RESTORE_POSTGRES_PASSWORD} psql -h ${RESTORE_POSTGRES_HOST} -U ${RESTORE_POSTGRES_USER} -d ${RESTORE_POSTGRES_DB} < $BACKUP_FILE