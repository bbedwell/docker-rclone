FROM alpine:3.4
MAINTAINER Bryce Bedwell <brycebedwell@gmail.com>

ENV COMMAND --version
ENV CRON_STRING * * * * *

RUN apk --no-cache add --update unzip curl \
 && curl -O http://downloads.rclone.org/rclone-current-linux-amd64.zip \
 && unzip rclone-current-linux-amd64.zip \
 && cd rclone-*-linux-amd64 \
 && cp rclone /usr/bin \
 && rm -rf rclone-*-linux-amd64

VOLUME ["/config"]

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
