FROM metabrainz/consul-template-base:0.18.2

# Pgbouncer and postgres are set up in the same container, because there is a
# 1:1 relationship between them which can't easily scale with swarm otherwise.

ARG DEBIAN_FRONTEND=noninteractive

COPY install_pgbouncer.sh /usr/local/bin/
RUN install_pgbouncer.sh

COPY install_postgres.sh /usr/local/bin/
RUN install_postgres.sh

COPY install_extensions.sh /usr/local/bin/
RUN install_extensions.sh

COPY pgbouncer.ini userlist.txt /etc/pgbouncer/
COPY pgbouncer.service /etc/service/pgbouncer/run
COPY postgres.service /etc/service/postgres/run
COPY run-postgres /usr/local/bin/
RUN chmod 755 \
    /etc/service/pgbouncer/run \
    /etc/service/postgres/run \
    /usr/local/bin/run-postgres

VOLUME ["/var/lib/postgresql/data"]

EXPOSE 5432 6899
