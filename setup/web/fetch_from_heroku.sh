#!/bin/bash -ve

if [ "$#" -ne 1 ]; then
    echo "Usage: setup/web/fetch_db_from_heroku.sh <dbName>"
    exit 1
fi

docker-compose rm -sf db

# If :latest is not empty:
docker rmi expirysync_db:latest
docker tag expirysync_db:empty expirysync_db:latest

docker-compose up -d db #<- This assumes that ':latest' is empty 
psql -U expiry_sync -h expiry-sync-db.local -d postgres -c "CREATE DATABASE expiry_sync ENCODING = 'utf8' TEMPLATE = 'template0'"
psql -U expiry_sync -h expiry-sync-db.local -d expiry_sync -c "CREATE EXTENSION IF NOT EXISTS plpgsql"
PGUSER=expiry_sync PGPASSWORD=admin heroku pg:pull $1 postgres://expiry-sync-db.local/expiry_sync
