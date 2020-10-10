FROM alpine:edge

RUN apk add --no-cache py-pip 

RUN pip install awscli

RUN apk add postgresql-client=12.4-r1

RUN set -x && apk update && rm -rf /var/lib/apt/lists/* 

COPY ./scripts/backup.sh /backup
COPY ./scripts/start.sh /start

RUN chmod +x /backup

RUN chmod 755 /backup /start


CMD ["/start"]

