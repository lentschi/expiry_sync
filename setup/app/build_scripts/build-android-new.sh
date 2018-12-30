#!/bin/bash -ve

if [ "$#" -ne 2 ]; then
    echo "USAGE: build-android-prod <version-code> <default-host>"
    exit 1
fi

export ANDROID_HOME=/opt/android-sdk-linux
export ANDROID_SDK=/opt/android-sdk-linux

# source "/root/.sdkman/bin/sdkman-init.sh"

# Crosswalk
cd /srv/project
cp -p platforms/android/app/build/outputs/apk/release/* /tmp || true
rm platforms/android/app/build/outputs/apk/release/* || true
cp -p config.xml /tmp
cp -p package.json /tmp
cp -p src/app/models/setting.ts /tmp
/srv/config/build_scripts/adept_config_xml.rb /srv/project/config.xml "$1"
export LC_ALL=C.UTF-8
/srv/config/build_scripts/adept_default_host_setting.rb /srv/project/src/app/models/setting.ts "$2"
ionic cordova build android --prod --release
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore deploy-keys/expiry-sync.keystore platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk expiry_sync_client
$ANDROID_HOME/build-tools/26.0.2/zipalign  -v 4 platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk platforms/android/app/build/outputs/apk/release/app-release-signed.apk
cp -p /tmp/config.xml ./
cp -p /tmp/package.json ./
cp -p /tmp/setting.ts ./src/app/models
