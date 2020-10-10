# REGULAR POSTGRES BACKUPS TO S3

Spins up a postgres docker container that connects to a remote postgres host, schedules pg_dumps and copies them to S3 bucket.
You may need to open up your postgres host to external connections. If you are running a RDS not allowing external connections, you could deploy the container within the VPC.

1. Following are the environment variables to be set.
    1. AWS_ACCESS_KEY_ID
    2. AWS_SECRET_ACCESS_KEY
    3. CRON_INTERVAL
    4. POSTGRES_BACKUP_BUCKET (S3 Bucket to be pushed to)
2. Tested with **postgres:11.3**.

