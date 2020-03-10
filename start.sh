#! /bin/sh

set -e

if [ "${REMOTE_POSTGRES_DB}" = "**None**"]; then
  echo "You need to set the REMOTE_POSTGRES_DB  environment variable."
  exit 1
fi

if [ "${REMOTE_POSTGRES_HOST}" = "**None**"]; then
  echo "You need to set the REMOTE_POSTGRES_HOST environment variable."
  exit 1
fi

if [ "${REMOTE_POSTGRES_USER}" = "**None**"]; then
  echo "You need to set the REMOTE_POSTGRES_USER  environment variable."
  exit 1
fi

if [ "${REMOTE_POSTGRES_PASSWORD}" = "**None**"]; then
  echo "You need to set the REMOTE_POSTGRES_PASSWORD  environment variable."
  exit 1
fi

if [ "${AWS_ACCESS_KEY_ID}" = "**None**"]; then
  echo "You need to set the AWS_ACCESS_KEY_ID  environment variable."
  exit 1
fi

if [ "${AWS_SECRET_ACCESS_KEY}" = "**None**"]; then
  echo "You need to set the AWS_SECRET_ACCESS_KEY  environment variable."
  exit 1
fi

if [ "${POSTGRES_BACKUP_BUCKET}" = "**None**"]; then
  echo "You need to set the POSTGRES_BACKUP_BUCKET  environment variable."
  exit 1
fi

echo "Creating dump of ${REMOTE_POSTGRES_DB} database from ${REMOTE_POSTGRES_HOST} ..."
DATE=`date +%Y-%m-%d`
BACKUP_FILE=${REMOTE_POSTGRES_DB}-`date +%Y-%m-%d-%H%M%S`.sql
PGPASSWORD=${REMOTE_POSTGRES_PASSWORD} pg_dump -h ${REMOTE_POSTGRES_HOST} -U ${REMOTE_POSTGRES_USER} -d ${REMOTE_POSTGRES_DB} > ./${BACKUP_FILE}

echo "Copying dump ${BACKUP_FILE} to ${POSTGRES_BACKUP_BUCKET}-${DATE}"
aws s3 cp ${BACKUP_FILE} s3://${POSTGRES_BACKUP_BUCKET}/${DATE}/
rm -f ${BACKUP_FILE}