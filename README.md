# docker-postgres

MetaBrainz postgres + pgbouncer container.

## Setup

```bash
docker build -t postgres-base -f postgres-base/Dockerfile .
docker build -t postgres-master -f postgres-master/Dockerfile .
docker build -t postgres-slave -f postgres-slave/Dockerfile .
```

`postgres-base` is the base image for `postgres-master` and `postgres-slave`;
it is not to be run by itself.
