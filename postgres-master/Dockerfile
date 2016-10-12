FROM metabrainz/postgres-base

COPY \
    consul-template.conf \
    pg_archive_command.sh.ctmpl \
    rsync_password_file.ctmpl \
    /etc/
COPY pg_hba.conf postgresql.conf.ctmpl /etc/postgresql/
