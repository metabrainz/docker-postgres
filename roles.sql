\set ON_ERROR_STOP 1
BEGIN;

CREATE ROLE replication WITH LOGIN REPLICATION;
CREATE ROLE musicbrainz_ro;
CREATE ROLE metabrainz WITH PASSWORD 'metabrainz';
CREATE ROLE caa_redirect WITH PASSWORD 'caa_redirect';
CREATE ROLE critiquebrainz WITH PASSWORD 'critiquebrainz';
CREATE ROLE mbspotify WITH PASSWORD 'mbspotify';
CREATE ROLE sentry WITH PASSWORD 'sentry';

COMMIT;
