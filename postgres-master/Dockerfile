FROM metabrainz/postgres-base:9.6

COPY \
    consul-template-postgres.conf \
    pg_archive_command.sh.ctmpl \
    rsync_password_file.ctmpl \
    /etc/
COPY postgresql.conf.ctmpl /etc/postgresql/
