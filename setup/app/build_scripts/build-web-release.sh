#!/bin/bash -v

set -e


cd /srv/project
cp -p config.xml /tmp
cp -p package.json /tmp
cp -p package-lock.json /tmp
/srv/config/ionic/prepare.sh
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
ionic cordova platform remove browser
ionic cordova platform add browser
cp -p /tmp/config.xml ./
export LC_ALL=C.UTF-8
ionic cordova build browser --prod
cp -Rfp platforms/browser /tmp
ionic cordova platform remove browser
cp -Rfp /tmp/browser platforms
cp -p /tmp/config.xml ./
cp -p /tmp/package.json ./
cp -p /tmp/package-lock.json ./