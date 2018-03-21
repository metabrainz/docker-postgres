\set ON_ERROR_STOP 1
BEGIN;

CREATE ROLE caa_redirect WITH LOGIN PASSWORD 'caa_redirect';
CREATE ROLE critiquebrainz WITH LOGIN PASSWORD 'critiquebrainz';
CREATE ROLE listenbrainz WITH LOGIN PASSWORD 'listenbrainz';
CREATE ROLE mbspotify WITH LOGIN PASSWORD 'mbspotify';
CREATE ROLE metabrainz WITH LOGIN PASSWORD 'metabrainz';
CREATE ROLE metabrainz_test WITH LOGIN PASSWORD 'metabrainz_test';
CREATE ROLE musicbrainz_ro WITH LOGIN;
CREATE ROLE replication WITH LOGIN REPLICATION;
CREATE ROLE sentry WITH LOGIN PASSWORD 'sentry';
CREATE ROLE telegraf WITH LOGIN;
CREATE ROLE sir WITH LOGIN PASSWORD 'sir';

ALTER ROLE musicbrainz_ro SET search_path TO musicbrainz, public;
ALTER ROLE sir SET search_path TO musicbrainz, public;

COMMIT;
