#!/bin/bash

set -e

apt-get update

BUILD_DEPS=" \
    gcc \
    git \
    libc6-dev \
    libicu-dev \
    make \
    pkg-config \
    postgresql-server-dev-9.6"

ICU_PKG=$(apt-cache search --names-only '^libicu5[0-9]$' | awk '{print $1}')

RUN_DEPS=" \
    ca-certificates \
    $ICU_PKG"

apt-get install \
    --no-install-recommends \
    --no-install-suggests \
    -y \
    $BUILD_DEPS \
    $RUN_DEPS

make_extension() {
    local ORG=$1
    local REPO=$2
    local COMMIT=$3

    cd /tmp
    git clone https://github.com/$ORG/$REPO.git
    pushd $REPO
    git reset --hard $COMMIT
    make && make install
    popd
    rm -rf $REPO
}

make_extension 'metabrainz' 'dbmirror' 'e050578'
make_extension 'metabrainz' 'postgresql-musicbrainz-collate' '6c350bc'
make_extension 'metabrainz' 'postgresql-musicbrainz-unaccent' 'b727896'
make_extension 'omniti-labs' 'pg_amqp' '1290d7c'

apt-get purge -y $BUILD_DEPS
apt-get autoremove -y
rm -rf /var/lib/apt/lists/*
