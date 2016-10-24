FROM metabrainz/consul-template-base

# Pgbouncer and postgres are set up in the same container, because there is a
# 1:1 relationship between them which can't easily scale with swarm otherwise.

ARG DEBIAN_FRONTEND=noninteractive

ARG RUN_DEPS=" \
    ca-certificates \
    libc-ares2 \
    libev4 \
    libevent-2.0-5 \
    libicu55 \
    libssl1.0.0 \
    locales \
    rsync"

ARG BUILD_DEPS=" \
    autoconf \
    automake \
    build-essential \
    git \
    libssl-dev \
    libtool \
    pkg-config \
    postgresql-server-dev-9.5"

RUN apt-get update && \
    apt-get install --no-install-recommends -y $RUN_DEPS $BUILD_DEPS

###############
## pgbouncer ##
###############

# Within a docker container, DNS lookups are broken in the official packaged
# versions of pgbouncer for trusty and jessie, plus the versions in the
# official PG repo for both of those distros. Some scant details can be found
# in this issue:
# https://github.com/pgbouncer/pgbouncer/issues/122
#
# This section of the Dockerfile was based on the following comment from the
# above issue:
# https://github.com/pgbouncer/pgbouncer/issues/122#issuecomment-199182461
#
# Which in turn was based on:
# https://hub.docker.com/r/mbentley/ubuntu-pgbouncer/~/dockerfile/
# https://github.com/mbentley/dockerfiles/tree/master/ubuntu/pgbouncer

ARG PGBOUNCER_BUILD_DEPS=" \
    libc-ares-dev \
    libev-dev \
    libevent-dev"

RUN apt-get update && \
    apt-get install --no-install-recommends -y $PGBOUNCER_BUILD_DEPS && \
    cd /tmp && \
    git clone https://github.com/pgbouncer/pgbouncer.git && \
    cd pgbouncer && \
    git checkout pgbouncer_1_7_2 && \
    git submodule init && \
    git submodule update && \
    ./autogen.sh && \
    ./configure --enable-evdns=no && \
    make && \
    make install && \
    apt-get purge -y $PGBOUNCER_BUILD_DEPS && \
    cd / && \
    rm -rf /tmp/pgbouncer /var/lib/apt/lists/*

##############
## postgres ##
##############

# https://github.com/docker-library/postgres/blob/04b1d36/9.5/Dockerfile#L37
RUN sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf && \
    apt-get update && \
    apt-get install --no-install-recommends -y \
        postgresql-9.5 \
        postgresql-contrib-9.5 && \
    rm -rf /var/lib/apt/lists/*

ENV PGDATA /var/lib/postgresql/data

RUN mkdir -p $PGDATA && \
    chown -R postgres:postgres $PGDATA && \
    chpst -u postgres:postgres \
        /usr/lib/postgresql/9.5/bin/initdb \
            --data-checksums \
            --encoding utf8 \
            --locale en_US.UTF8 \
            $PGDATA

################
## extensions ##
################

RUN cd /tmp && \
    git clone https://github.com/metabrainz/dbmirror.git && \
    cd dbmirror && \
    git reset --hard e0505788dde75b0ea0efe895c5c311b0f5aa757f && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/dbmirror

RUN apt-get update && \
    apt-get install --no-install-recommends -y libicu-dev && \
    cd /tmp && \
    git clone https://github.com/metabrainz/postgresql-musicbrainz-collate.git && \
    cd postgresql-musicbrainz-collate && \
    git reset --hard 958142e03c5d035bb215a4296fd09bcf388b833a && \
    make && \
    make install && \
    apt-get purge -y libicu-dev && \
    cd / && \
    rm -rf /tmp/postgresql-musicbrainz-collate /var/lib/apt/lists/*

RUN cd /tmp && \
    git clone https://github.com/metabrainz/postgresql-musicbrainz-unaccent.git && \
    cd postgresql-musicbrainz-unaccent && \
    git reset --hard a32ca6a3e39c55b89dee85aabe770728dd896aef && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/postgresql-musicbrainz-unaccent

RUN cd /tmp && \
    git clone https://github.com/omniti-labs/pg_amqp.git && \
    cd pg_amqp && \
    git reset --hard 1290d7cfd4c7ba1e2d7a502708dcfeb53b308f3b && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/pg_amqp

#############
## cleanup ##
#############

RUN apt-get purge -y $BUILD_DEPS && \
    apt-get autoremove -y

###################
## configuration ##
###################

COPY pgbouncer.ini.ctmpl userlist.txt /etc/pgbouncer/
COPY pgbouncer.service /etc/service/pgbouncer/run
COPY postgres.service /etc/service/postgres/run
RUN chmod 755 /etc/service/pgbouncer/run /etc/service/postgres/run

VOLUME ["/var/lib/postgresql/data"]
