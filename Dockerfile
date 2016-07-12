FROM multiarch/crossbuild
MAINTAINER Octoblu, Inc. <docker@octoblu.com>

RUN dpkg --add-architecture armhf
RUN apt-get update \
  && apt-get install -y \
    libusb-1.0-0-dev:armhf \
    libbluetooth-dev:armhf \
    libudev-dev:armhf

RUN mkdir -p /opt/node
RUN curl -L https://nodejs.org/dist/latest-v5.x/node-v5.12.0-linux-x64.tar.gz | tar --strip 1 -xz -C /opt/node
RUN curl -L https://github.com/aktau/github-release/releases/download/v0.6.2/linux-amd64-github-release.tar.bz2 | tar -xj --strip 3 -C /usr/local/bin

ENV CROSS_TRIPLE arm-linux-gnueabi
COPY compile.sh /usr/local/bin/compile
