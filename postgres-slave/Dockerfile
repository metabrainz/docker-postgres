FROM metabrainz/postgres-base:9.6

# These services should not be started until data is copied from the master.
RUN touch \
    /etc/service/pgbouncer/down \
    /etc/service/postgres/down

RUN mkdir -p /var/tmp/pg_archive && \
    chown -R postgres:postgres /var/tmp/pg_archive

COPY \
    consul-template-postgres.conf \
    consul-template-rsyncd.conf \
    rsyncd.secrets.ctmpl \
    rsyncd.conf \
    /etc/
COPY postgresql.conf.ctmpl recovery.conf.ctmpl /etc/postgresql/
COPY pg_restore_command.sh /usr/local/bin/
COPY rsyncd.service /etc/service/rsyncd/run

VOLUME ["/var/tmp/pg_archive"]

EXPOSE 873
