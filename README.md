# REGULAR POSTGRES BACKUPS TO S3

Spins up a postgres docker container that connects to a remote postgres host, schedules pg_dumps and copies them to S3 bucket.
You may need to open up your postgres host to external connections. If you are running a RDS not allowing external connections, you could deploy the container within the VPC.

1. Set the AWS environment variables and the S3 Bucket.
2. Set the environment variables prefixed with 'REMOTE\_' with your remote postgres host creds.
3. Terraform VPC example maybe in the future.
4. Uses go-cron for verbosity. May switch to normal cron in the future.
