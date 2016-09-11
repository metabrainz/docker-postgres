FROM ubuntu:16.04

COPY docker-helpers/install_consul_template.sh \
    docker-helpers/install_runit.sh \
    /usr/local/bin/
RUN install_consul_template.sh && \
    rm -f \
        /usr/local/bin/install_consul_template.sh \
        /usr/local/bin/install_runit.sh

# Pgbouncer and postgres are set up in the same container, because there is a
# 1:1 relationship between them which can't easily scale with swarm otherwise.

# https://github.com/docker-library/postgres/blob/04b1d36/9.5/Dockerfile#L4
RUN groupadd -r postgres --gid=999 && \
    useradd -r -g postgres --uid=999 postgres

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        automake \
        build-essential \
        ca-certificates \
        git \
        libc-ares-dev \
        libc-ares2 \
        libev-dev \
        libev4 \
        libevent-2.0-5 \
        libevent-dev \
        libicu-dev \
        libssl-dev \
        libssl1.0.0 \
        libtool \
        locales \
        pkg-config \
        rsync \
        vim && \
    rm -rf /var/lib/apt/lists/*

# https://github.com/docker-library/postgres/blob/04b1d36/9.5/Dockerfile#L21
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

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

RUN cd /tmp && \
    git clone https://github.com/pgbouncer/pgbouncer.git && \
    cd pgbouncer && \
    git checkout pgbouncer_1_7_2 && \
    git submodule init && \
    git submodule update && \
    ./autogen.sh && \
    ./configure --enable-evdns=no && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/pgbouncer

RUN mkdir -p /etc/pgbouncer && \
    mkdir -p /var/run/postgresql && \
    touch /var/log/postgresql && \
    chown -R postgres:postgres /var/log/postgresql && \
    chown -R postgres:postgres /var/run/postgresql

##############
## postgres ##
##############

RUN apt-get update && \
    apt-get install -y --no-install-recommends postgresql-common && \
    # https://github.com/docker-library/postgres/blob/04b1d36/9.5/Dockerfile#L37
    sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf && \
    apt-get install -y --no-install-recommends \
        postgresql-9.5 \
        postgresql-contrib-9.5 \
        postgresql-server-dev-9.5 && \
    rm -rf /var/lib/apt/lists/*

ENV PGDATA /var/lib/postgresql/data
RUN mkdir -p $PGDATA && \
    chown -R postgres:postgres $PGDATA && \
    pg_createcluster -d $PGDATA 9.5 main

################
## extensions ##
################

RUN cd /tmp && \
    git clone https://github.com/metabrainz/postgresql-musicbrainz-collate.git && \
    cd postgresql-musicbrainz-collate && \
    git reset --hard 958142e03c5d035bb215a4296fd09bcf388b833a && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/postgresql-musicbrainz-collate

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

###################
## configuration ##
###################

COPY postgres-base/pgbouncer.ini postgres-base/userlist.txt /etc/pgbouncer/
COPY postgres-base/pgbouncer.service /etc/sv/pgbouncer/run
COPY postgres-base/postgres.service /etc/sv/postgres/run
RUN chmod 755 /etc/sv/pgbouncer/run /etc/sv/postgres/run && \
    ln -s /etc/sv/pgbouncer /etc/service/ && \
    ln -s /etc/sv/postgres /etc/service/

VOLUME ["/var/lib/postgresql/data"]

ENTRYPOINT ["/usr/local/bin/runsvinit"]
