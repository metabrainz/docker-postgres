FROM metabrainz/consul-template-base

# Pgbouncer and postgres are set up in the same container, because there is a
# 1:1 relationship between them which can't easily scale with swarm otherwise.

RUN apk add --no-cache \
        c-ares \
        icu \
        libev \
        libevent \
        openssl \
        rsync && \
    apk add --no-cache --virtual .build-deps \
        autoconf \
        automake \
        ca-certificates \
        gcc \
        git \
        libtool \
        m4 \
        make \
        musl-dev \
        pkgconfig

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

RUN apk add --no-cache --virtual .pgbouncer-build-deps \
        c-ares-dev \
        libev-dev \
        libevent-dev \
        openssl-dev && \
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
    cd / && \
    rm -rf /tmp/pgbouncer && \
    apk del .pgbouncer-build-deps

##############
## postgres ##
##############

RUN apk add --no-cache postgresql postgresql-contrib && \
    apk add --no-cache --virtual .build-deps postgresql-dev

ENV PGDATA /var/lib/postgresql/data

RUN chpst -u postgres:postgres initdb --encoding utf8 --locale C $PGDATA

################
## extensions ##
################

RUN apk add --no-cache --virtual .collate-build-deps icu-dev && \
    cd /tmp && \
    git clone https://github.com/metabrainz/postgresql-musicbrainz-collate.git && \
    cd postgresql-musicbrainz-collate && \
    git reset --hard 958142e03c5d035bb215a4296fd09bcf388b833a && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/postgresql-musicbrainz-collate && \
    apk del .collate-build-deps

RUN cd /tmp && \
    git clone https://github.com/metabrainz/postgresql-musicbrainz-unaccent.git && \
    cd postgresql-musicbrainz-unaccent && \
    git reset --hard a32ca6a3e39c55b89dee85aabe770728dd896aef && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/postgresql-musicbrainz-unaccent

COPY timeval.patch /tmp/

RUN cd /tmp && \
    git clone https://github.com/omniti-labs/pg_amqp.git && \
    cd pg_amqp && \
    git reset --hard 1290d7cfd4c7ba1e2d7a502708dcfeb53b308f3b && \
    git apply /tmp/timeval.patch && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/pg_amqp /tmp/timeval.patch

###################
## configuration ##
###################

COPY pgbouncer.ini userlist.txt /etc/pgbouncer/
COPY pgbouncer.service /etc/sv/pgbouncer/run
COPY postgres.service /etc/sv/postgres/run
RUN chmod 755 /etc/sv/pgbouncer/run /etc/sv/postgres/run && \
    ln -s /etc/sv/pgbouncer /etc/service/ && \
    ln -s /etc/sv/postgres /etc/service/

VOLUME ["/var/lib/postgresql/data"]

ENTRYPOINT ["/usr/local/bin/runsvinit"]

EXPOSE 5432 6899
