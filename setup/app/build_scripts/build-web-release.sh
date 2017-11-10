#!/bin/bash -v

set -e

if [ "$#" -ne 1 ]; then
    echo "USAGE: build-web-release <default-host>"
    exit 1
fi

cd /srv/project
cp -p config.xml /tmp
cp -p package.json /tmp
cp -p npm-shrinkwrap.json /tmp
cp -p src/app/models/setting.ts /tmp
ionic cordova platform remove browser
ionic cordova platform add browser
cp -p /tmp/config.xml ./
export LC_ALL=C.UTF-8
/srv/config/build_scripts/adept_default_host_setting.rb /srv/project/src/app/models/setting.ts "$1"
ionic cordova build browser --prod
cp -Rfp platforms/browser /tmp
ionic cordova platform remove browser
cp -Rfp /tmp/browser platforms
cp -p /tmp/config.xml ./
cp -p /tmp/package.json ./
cp -p /tmp/npm-shrinkwrap.json ./
cp -p /tmp/setting.ts ./src/app/models
