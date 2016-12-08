\set ON_ERROR_STOP 1
BEGIN;

-- musicbrainz_ro
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA musicbrainz FROM musicbrainz_ro;
REVOKE ALL PRIVILEGES ON SCHEMA musicbrainz FROM musicbrainz_ro;

GRANT CONNECT ON DATABASE musicbrainz_db TO musicbrainz_ro;
GRANT USAGE ON SCHEMA musicbrainz TO musicbrainz_ro;
GRANT SELECT ON ALL TABLES IN SCHEMA musicbrainz TO musicbrainz_ro;

-- telegraf
REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA musicbrainz FROM telegraf;
REVOKE ALL PRIVILEGES ON SCHEMA musicbrainz FROM telegraf;

GRANT CONNECT ON DATABASE musicbrainz_db TO telegraf;
GRANT USAGE ON SCHEMA pg_catalog TO telegraf;
GRANT SELECT ON pg_catalog.pg_stat_database, pg_catalog.pg_stat_bgwriter TO telegraf;

-- CAA redirect
GRANT CONNECT ON DATABASE musicbrainz_db TO caa_redirect;
GRANT USAGE ON SCHEMA musicbrainz TO caa_redirect;
GRANT SELECT ON ALL TABLES IN SCHEMA musicbrainz TO caa_redirect;
GRANT USAGE ON SCHEMA cover_art_archive TO caa_redirect;
GRANT SELECT ON ALL TABLES IN SCHEMA cover_art_archive TO caa_redirect;

COMMIT;
