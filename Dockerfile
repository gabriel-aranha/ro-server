FROM debian:bullseye-slim

ARG HERCULES_PACKET_VERSION=20130807

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    make \
    libmariadb-dev \
    libmariadb-dev-compat \
    zlib1g-dev \
    libpcre3-dev \
    git

ENV BUILD_WORKSPACE=/build
ENV HERCULES_SRC=${BUILD_WORKSPACE}/Hercules

COPY . ${BUILD_WORKSPACE}

RUN cd ${HERCULES_SRC} && ./configure --disable-renewal --enable-packetver=${HERCULES_PACKET_VERSION}

RUN cd ${HERCULES_SRC} && make

RUN rm -rf ${HERCULES_SRC}/conf/import-tmpl

RUN cp -r ${BUILD_WORKSPACE}/templates/. ${HERCULES_SRC}

EXPOSE 6900 6121 5121

CMD [ "build/Hercules/docker-entrypoint.sh"  ]