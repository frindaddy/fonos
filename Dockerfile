FROM node:20-alpine AS ui-build
WORKDIR /root/fonos-server
COPY /icon.jpg ./icon.jpg

RUN apk upgrade && apk add snapcast-server

EXPOSE 1704