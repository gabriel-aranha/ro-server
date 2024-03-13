FROM debian:bullseye-slim AS build_hercules

ARG HERCULES_PACKET_VERSION=20130807

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    make \
    libmariadb-dev \
    libmariadb-dev-compat \
    zlib1g-dev \
    libpcre3-dev \
    git

ENV WORKSPACE=/build
ENV HERCULES_SRC=${WORKSPACE}/Hercules

COPY . ${WORKSPACE}

RUN cd ${HERCULES_SRC} && ./configure --enable-packetver=${HERCULES_PACKET_VERSION}

RUN cd ${HERCULES_SRC} && make