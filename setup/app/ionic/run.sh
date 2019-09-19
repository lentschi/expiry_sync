#!/bin/bash -ve
/srv/config/ionic/prepare.sh
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
cd /srv/project
#ionic serve --no-interactive --no-open --port 80
./node_modules/.bin/ng serve --no-open --host "0.0.0.0" --port 443 --disable-host-check --ssl --ssl-cert /srv/config/cert/expirysync_client.crt --ssl-key /srv/config/cert/expirysync_client.cert.key
