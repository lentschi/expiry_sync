#!/bin/bash -ve

set -e

source "/$HOME/.sdkman/bin/sdkman-init.sh"
export ANDROID_HOME=/opt/android-sdk-linux
export ANDROID_SDK=/opt/android-sdk-linux

# not sure why the group may not be kvm (for some reason when entering the console
# the user web only has the web group, despite actually having kvm too - see `groups web`.):
sudo chgrp web /dev/kvm

nohup $ANDROID_HOME/emulator/emulator @test &

sleep 5

cd /srv/project
cp -p config.xml /tmp
cp -p package.json /tmp
cp -p package-lock.json /tmp
/srv/config/ionic/prepare.sh
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
ionic cordova run android --livereload --livereload-url=https://expiry_sync_app
cp -p /tmp/config.xml ./
cp -p /tmp/package.json ./
cp -p /tmp/package-lock.json ./