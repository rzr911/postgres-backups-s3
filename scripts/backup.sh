#! /bin/sh

set -e


echo "Creating dump of ${POSTGRES_DB} database from ${POSTGRES_HOST} ..."
DATE=`date +%Y-%m-%d`
BACKUP_FILE=${POSTGRES_DB}-`date +%Y-%m-%d-%H%M%S`.sql
PGPASSWORD=${POSTGRES_PASSWORD} pg_dump -h ${POSTGRES_HOST} -U ${POSTGRES_USER} -d ${POSTGRES_DB} > ./${BACKUP_FILE}

echo "Copying dump ${BACKUP_FILE} to ${POSTGRES_BACKUP_BUCKET}/${DATE}"
aws s3 cp ${BACKUP_FILE} s3://${POSTGRES_BACKUP_BUCKET}/${DATE}/
rm -f ${BACKUP_FILE}
echo "Pushed  ${BACKUP_FILE} to ${POSTGRES_BACKUP_BUCKET}/${DATE}"
