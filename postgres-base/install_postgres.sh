#!/bin/bash

set -e

RUN_DEPS=" \
    locales \
    postgresql-9.6 \
    postgresql-contrib-9.6 \
    postgresql-plperl-9.6 \
    rsync"

add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
apt-get update

apt-get install \
    --no-install-recommends \
    --no-install-suggests \
    -y \
    postgresql-common

sed -ri \
    's/#(create_main_cluster) .*$/\1 = false/' \
    /etc/postgresql-common/createcluster.conf

apt-get install \
    --no-install-recommends \
    --no-install-suggests \
    -y \
    $RUN_DEPS

rm -rf /var/lib/apt/lists/*

export PGDATA=/var/lib/postgresql/data
mkdir -p $PGDATA
chown -R postgres:postgres $PGDATA

chpst -u postgres:postgres \
    /usr/lib/postgresql/9.6/bin/initdb \
        --data-checksums \
        --encoding utf8 \
        --no-locale \
        --username postgres \
        $PGDATA
