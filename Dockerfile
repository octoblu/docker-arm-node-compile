FROM resin/rpi-raspbian:jessie
MAINTAINER Octoblu, Inc. <docker@octoblu.com>

RUN apt-get update \
    && apt-get install -y \
      build-essential \
      curl \
      git \
      ca-certificates \
      libusb-1.0-0-dev \
      libbluetooth-dev \
      libudev-dev

RUN curl -sL "https://deb.nodesource.com/setup_5.x" \
    |  bash - \
    && apt-get install nodejs -y

COPY compile.sh .
