#!/bin/bash

set -e

RUN_DEPS=" \
    locales \
    postgresql-10 \
    postgresql-contrib-10 \
    postgresql-plperl-10 \
    rsync"

add-apt-repository 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main'
apt-key add /tmp/ACCC4CF8.asc
rm /tmp/ACCC4CF8.asc
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
    /usr/lib/postgresql/10/bin/initdb \
        --data-checksums \
        --encoding utf8 \
        --no-locale \
        --username postgres \
        $PGDATA
