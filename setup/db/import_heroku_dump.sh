#!/bin/bash -e

dropdb expiry_sync
createdb --owner expiry_sync --template=template0 --encoding=UTF8 expiry_sync
pg_restore -d expiry_sync --no-owner -1  -x /srv/project/latest.dump
psql -c "ALTER DATABASE expiry_sync OWNER TO expiry_sync;"
for table in `psql -tc "select tablename from pg_tables where schemaname = 'public';" expiry_sync` ; do  psql -c "alter table public.${table} owner to expiry_sync" expiry_sync ; done
