FROM debian:bullseye-slim

ARG HERCULES_PACKET_VERSION=20220406

RUN useradd --no-log-init -r hercules

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    make \
    libmariadb3 \
    libmariadb-dev \
    libmariadb-dev-compat \
    zlib1g-dev \
    libpcre3-dev \
    git

ENV BUILD_WORKSPACE=/build
ENV HERCULES_SRC=${BUILD_WORKSPACE}/Hercules

COPY . ${BUILD_WORKSPACE}

RUN cd ${HERCULES_SRC} && ./configure --disable-manager --enable-packetver=${HERCULES_PACKET_VERSION}

RUN cd ${HERCULES_SRC} && make

RUN cp -r ${BUILD_WORKSPACE}/templates/. ${HERCULES_SRC}

RUN rm ${HERCULES_SRC}/sql-files/item_db.sql
RUN rm ${HERCULES_SRC}/sql-files/mob_db.sql
RUN rm ${HERCULES_SRC}/sql-files/mob_skill_db.sql

EXPOSE 6900 6121 5121

USER hercules

WORKDIR /build/Hercules

CMD [ "./docker-entrypoint.sh"  ]