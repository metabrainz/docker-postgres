FROM metabrainz/postgres-base

RUN cd /tmp && \
    git clone https://github.com/metabrainz/dbmirror.git && \
    cd dbmirror && \
    git reset --hard e0505788dde75b0ea0efe895c5c311b0f5aa757f && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/dbmirror

RUN apk del .build-deps

COPY consul-template.conf pg_archive_command.sh.ctmpl /etc/
COPY pg_hba.conf.ctmpl postgresql.conf.ctmpl /etc/postgresql/
