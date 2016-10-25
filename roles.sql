\set ON_ERROR_STOP 1
BEGIN;

CREATE ROLE replication WITH LOGIN REPLICATION;
CREATE ROLE musicbrainz_ro;
CREATE USER metabrainz WITH PASSWORD 'metabrainz';
CREATE USER caa_redirect WITH PASSWORD 'caa_redirect';
CREATE USER critiquebrainz WITH PASSWORD 'critiquebrainz';
CREATE USER mbspotify WITH PASSWORD 'mbspotify';
CREATE USER sentry WITH PASSWORD 'sentry';

COMMIT;
