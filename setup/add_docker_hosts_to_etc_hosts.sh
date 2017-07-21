#!/bin/bash -ve

# makeshift script to add all the docker hosts to local /etc/hosts
# requires https://gist.github.com/lentschi/63d073467a7c59c1c0dac8c1951341f0 to be in PATH

add_docker_host expiry_sync_web expiry-sync-web.local
add_docker_host expiry_sync_db expiry-sync-db.local
add_docker_host expiry_sync_mail expiry-sync-mail.local
add_docker_host expiry_sync_app expiry-sync-app.local
