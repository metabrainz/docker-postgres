FROM metabrainz/postgres-base

# These services should not be started until data is copied from the master.
RUN touch \
    /etc/service/pgbouncer/down \
    /etc/service/postgres/down

RUN mkdir -p /var/tmp/pg_archive && \
    chown -R postgres:postgres /var/tmp/pg_archive

COPY consul-template.conf rsyncd.secrets.ctmpl rsyncd.conf /etc/
COPY pg_hba.conf postgresql.conf.ctmpl recovery.conf.ctmpl /etc/postgresql/
COPY rsyncd.service /etc/service/rsyncd/run

VOLUME ["/var/tmp/pg_archive"]

EXPOSE 873
