FROM debian:latest
MAINTAINER https://github.com/dtandersen/steam-egg

RUN apt-get update && \
  apt-get install lib32gcc1 curl -y && \
  adduser --disabled-password --home /home/container --gecos "" container

USER container

WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh
