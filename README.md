# docker-postgres

MetaBrainz postgres + pgbouncer container.

Running `make` produces a `metabrainz/postgres-master:12` image.

The container should be started with `--dns-opt randomize-case:0` to work around [this issue](https://github.com/pgbouncer/pgbouncer/issues/122).
