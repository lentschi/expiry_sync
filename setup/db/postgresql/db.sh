#!/bin/bash -v

set -e


rm /etc/postgresql/9.5/main/pg_hba.conf || true
cp /srv/config/postgresql/pg_hba.conf /etc/postgresql/9.5/main
chown postgres:postgres /etc/postgresql/9.5/main/pg_hba.conf

rm /etc/postgresql/9.5/main/postgresql.conf || true
cp /srv/config/postgresql/postgresql.conf /etc/postgresql/9.5/main
chown postgres:postgres /etc/postgresql/9.5/main/postgresql.conf

service postgresql restart

sudo -u postgres psql -c "CREATE USER expiry_sync with createdb login PASSWORD 'admin';" || true
