\set ON_ERROR_STOP 1
BEGIN;

CREATE ROLE caa_redirect WITH PASSWORD 'caa_redirect';
CREATE ROLE critiquebrainz WITH PASSWORD 'critiquebrainz';
CREATE ROLE mbspotify WITH PASSWORD 'mbspotify';
CREATE ROLE metabrainz WITH PASSWORD 'metabrainz';
CREATE ROLE musicbrainz_ro;
CREATE ROLE replication WITH LOGIN REPLICATION;
CREATE ROLE sentry WITH PASSWORD 'sentry';

COMMIT;
