#!/bin/bash

# Within a docker container, DNS lookups are broken in the official packaged
# versions of pgbouncer for trusty and jessie, plus the versions in the
# official PG repo for both of those distros. Some scant details can be found
# in this issue:
# https://github.com/pgbouncer/pgbouncer/issues/122

set -e

VERSION=1.7.2
DIST_NAME=pgbouncer-$VERSION
FILE_NAME=$DIST_NAME.tar.gz

BUILD_DEPS=" \
    gcc \
    libc-ares-dev \
    libevent-dev \
    libc6-dev \
    make"

RUN_DEPS=" \
    libc-ares2 \
    libevent-2.0-5"

apt-get update
apt-get install \
    --no-install-recommends \
    --no-install-suggests \
    -y \
    $BUILD_DEPS \
    $RUN_DEPS

cd /tmp
curl -O https://pgbouncer.github.io/downloads/files/1.7.2/$FILE_NAME
tar xvzf $FILE_NAME
rm $FILE_NAME

pushd $DIST_NAME
./configure --enable-evdns=no --with-cares --without-openssl
make && make install
popd

apt-get purge -y $BUILD_DEPS
apt-get autoremove -y
rm -rf $DIST_NAME /var/lib/apt/lists/*
