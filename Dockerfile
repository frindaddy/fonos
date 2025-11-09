FROM alpine:edge

RUN apk upgrade

# install librespot dependencies and build tools
RUN apk add --no-cache git rust cargo build-base openssl-dev alsa-lib-dev
RUN git clone https://github.com/librespot-org/librespot /opt/librespot
RUN cd /opt/librespot && cargo build --release && cd /

# get snapcast from edge/testing to have up to date version
RUN apk add --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing --no-cache snapcast-server

# download and install snapweb
RUN apk add wget unzip
RUN wget https://github.com/badaix/snapweb/releases/download/v0.8.0/snapweb.zip -O /usr/share/snapserver/snapweb/snapweb.zip
RUN unzip -o /usr/share/snapserver/snapweb/snapweb.zip -d /usr/share/snapserver/snapweb/ && rm /usr/share/snapserver/snapweb/snapweb.zip

COPY /snapserver.conf /etc/snapserver.conf
CMD ["snapserver"]

# 1704 for snapcast server, 1780 for snapweb
EXPOSE 1704 1780