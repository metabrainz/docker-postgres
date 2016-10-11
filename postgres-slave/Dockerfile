FROM metabrainz/postgres-base

RUN mkdir -p /var/tmp/pg_archive && \
    chown -R postgres:postgres /var/tmp/pg_archive

COPY consul-template.conf rsyncd.secrets.ctmpl rsyncd.conf /etc/
COPY pg_hba.conf.ctmpl postgresql.conf.ctmpl /etc/postgresql/
COPY recovery.conf.ctmpl /var/lib/postgresql/data/
COPY rsyncd.service /etc/service/rsyncd/run

VOLUME ["/var/tmp/pg_archive"]

EXPOSE 873
