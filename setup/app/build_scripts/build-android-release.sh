#!/bin/bash -ve

if [ "$#" -ne 2 ]; then
    echo "USAGE: build-android-prod <version-code> <default-host>"
    exit 1
fi


rm -Rf /tmp/out || true
mkdir /tmp/out
export ANDROID_HOME=/opt/android-sdk-linux
export ANDROID_SDK=/opt/android-sdk-linux

source "/root/.sdkman/bin/sdkman-init.sh"

# Crosswalk
cd /srv/project
cp -p config.xml /tmp
cp -p package.json /tmp
cp -p npm-shrinkwrap.json /tmp
cp -p src/app/models/setting.ts /tmp
ionic cordova platform remove android || true
ionic cordova plugin add cordova-plugin-crosswalk-webview@2.3.0
ionic cordova platform add android
/srv/config/build_scripts/adept_config_xml.rb /srv/project/config.xml "$1" --crosswalk
export LC_ALL=C.UTF-8
/srv/config/build_scripts/adept_default_host_setting.rb /srv/project/src/app/models/setting.ts "$2"
ionic cordova build android --prod --release
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore deploy-keys/expiry-sync.keystore platforms/android/build/outputs/apk/android-armv7-release-unsigned.apk expiry_sync_client
$ANDROID_HOME/build-tools/26.0.0/zipalign  -v 4 platforms/android/build/outputs/apk/android-armv7-release-unsigned.apk platforms/android/build/outputs/apk/expiry-sync-signed-crosswalk.apk
cp platforms/android/build/outputs/apk/expiry-sync-signed-crosswalk.apk /tmp/out
ionic cordova plugin remove cordova-plugin-crosswalk-webview
ionic cordova platform remove android
ionic cordova platform add android
cp -p /tmp/config.xml ./

# Non-crosswalk
/srv/config/build_scripts/adept_config_xml.rb /srv/project/config.xml "$1"
ionic cordova build android --prod --release
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore deploy-keys/expiry-sync.keystore platforms/android/build/outputs/apk/android-release-unsigned.apk expiry_sync_client
$ANDROID_HOME/build-tools/26.0.0/zipalign -v 4 platforms/android/build/outputs/apk/android-release-unsigned.apk platforms/android/build/outputs/apk/expiry-sync-signed.apk
cp platforms/android/build/outputs/apk/expiry-sync-signed.apk /tmp/out
cp -p /tmp/config.xml ./
cp -p /tmp/package.json ./
cp -p /tmp/npm-shrinkwrap.json ./
cp -p /tmp/setting.ts ./src/app/models

rm platforms/android/build/outputs/apk/*
cp /tmp/out/* platforms/android/build/outputs/apk
rm -Rf /tmp/out
