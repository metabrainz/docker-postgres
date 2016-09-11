FROM postgres-base

RUN cd /tmp && \
    git clone https://github.com/metabrainz/dbmirror.git && \
    cd dbmirror && \
    git reset --hard e0505788dde75b0ea0efe895c5c311b0f5aa757f && \
    make && \
    make install && \
    cd / && \
    rm -rf /tmp/dbmirror

COPY postgres-master/consul-template.conf \
    postgres-master/pg_archive_command.sh.ctmpl \
    /etc/
COPY postgres-master/pg_hba.conf.ctmpl \
    postgres-master/postgresql.conf.ctmpl \
    /etc/postgresql/
