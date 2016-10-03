FROM metabrainz/postgres-base

RUN apk del .build-deps

RUN mkdir -p /var/tmp/pg_archive && \
    chown -R postgres:postgres /var/tmp/pg_archive

COPY consul-template.conf rsync.secrets.ctmpl rsyncd.conf.ctmpl /etc/
COPY pg_hba.conf.ctmpl postgresql.conf.ctmpl /etc/postgresql/
COPY recovery.conf.ctmpl /var/lib/postgresql/data/

COPY rsyncd.service /etc/sv/rsyncd/run
RUN ln -s /etc/sv/rsyncd /etc/service/

VOLUME ["/var/tmp/pg_archive"]

EXPOSE 873
