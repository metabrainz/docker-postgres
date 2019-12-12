FROM metabrainz/postgres-base:12

COPY \
    consul-template-postgres.conf \
    pg_archive_command.sh.ctmpl \
    rsync_password_file.ctmpl \
    /etc/
COPY postgresql.conf.ctmpl /etc/postgresql/
