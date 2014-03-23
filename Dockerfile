FROM ubuntu:raring
MAINTAINER lonnen "lonnen@mozilla.com"

RUN mkdir /build
ADD ./stack/ /build
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /build/prepare
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean
