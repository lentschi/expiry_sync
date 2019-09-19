#!/bin/bash

cd /srv/project
/srv/config/ionic/prepare.sh
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
./node_modules/.bin/webdriver-manager update
node --inspect=0.0.0.0:9200 ./node_modules/.bin/protractor ./e2e/protractor.conf.js