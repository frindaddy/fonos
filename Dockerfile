FROM alpine:edge

ARG LIBRESPOT_VERSION=0.6.0-r0
ARG SNAPCAST_VERSION=0.31.0-r0

RUN apk upgrade
RUN apk add --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing --no-cache bash snapcast-server=${SNAPCAST_VERSION} librespot=${LIBRESPOT_VERSION} sed
RUN apk add wget unzip
RUN wget https://github.com/badaix/snapweb/releases/download/v0.8.0/snapweb.zip -O /usr/share/snapserver/snapweb/snapweb.zip
RUN unzip -o /usr/share/snapserver/snapweb/snapweb.zip -d /usr/share/snapserver/snapweb/ && rm /usr/share/snapserver/snapweb/snapweb.zip

COPY /snapserver.conf /etc/snapserver.conf
CMD ["snapserver"]

EXPOSE 1704 1780