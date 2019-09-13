#!/bin/bash -ve


export ANDROID_HOME=/opt/android-sdk-linux
export ANDROID_SDK=/opt/android-sdk-linux

source "$HOME/.sdkman/bin/sdkman-init.sh"

cd /srv/project
rm platforms/android/app/build/outputs/apk/release/* || true
cp -p config.xml /tmp
cp -p package.json /tmp
cp -p package-lock.json /tmp
ionic cordova platform remove android
ionic cordova platform add android
cp -p /tmp/config.xml ./
ionic cordova build android --prod --release
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore deploy-keys/expiry-sync.keystore platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk expiry_sync_client
$ANDROID_HOME/build-tools/28.0.3/zipalign -v 4 platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk platforms/android/app/build/outputs/apk/release/app-release-signed.apk
cp -p /tmp/config.xml ./
cp -p /tmp/package.json ./
cp -p /tmp/package-lock.json ./
ls -lah platforms/android/app/build/outputs/apk/release/app-release-signed.apk