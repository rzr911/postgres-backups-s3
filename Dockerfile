FROM postgres:10.5

RUN set -x \
  && apt-get update && apt-get install -y  curl awscli && rm -rf /var/lib/apt/lists/* \
  && curl -L https://github.com/odise/go-cron/releases/download/v0.0.7/go-cron-linux.gz | zcat > /usr/local/bin/go-cron \
  && chmod a+x /usr/local/bin/go-cron


COPY ./backup.sh /backup
RUN sed -i 's/\r//' /backup
RUN chmod +x /backup

ENTRYPOINT ["/bin/sh", "-c"]
CMD ["exec /usr/local/bin/go-cron -s \"$SCHEDULE\" -p \"$HEALTHCHECK_PORT\" -- /backup"]

HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f "http://localhost:$HEALTHCHECK_PORT/" || exit 1

