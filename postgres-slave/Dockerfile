FROM metabrainz/postgres-base

RUN apk del .build-deps

RUN mkdir -p /var/tmp/pg_archive && \
    chown -R postgres:postgres /var/tmp/pg_archive

COPY postgres-slave/consul-template.conf \
    postgres-slave/rsyncd.conf.ctmpl \
    /etc/
COPY postgres-slave/pg_hba.conf.ctmpl \
    postgres-slave/postgresql.conf.ctmpl \
    /etc/postgresql/
COPY postgres-slave/recovery.conf.ctmpl /var/lib/postgresql/data/

COPY postgres-slave/rsyncd.service /etc/sv/rsyncd/run
RUN ln -s /etc/sv/rsyncd /etc/service/

VOLUME ["/var/tmp/pg_archive"]
