#!/bin/bash -v

set -e

source "/home/web/.sdkman/bin/sdkman-init.sh"
export ANDROID_HOME=/opt/android-sdk-linux
export ANDROID_SDK=/opt/android-sdk-linux
cd /srv/project
cp -p config.xml /tmp
cp -p package.json /tmp
ionic cordova platform remove android
ionic cordova platform add android
cp -p /tmp/config.xml ./
ionic cordova build android
cp -p /tmp/config.xml ./
cp -p /tmp/package.json ./