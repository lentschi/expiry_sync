#!/bin/bash -ve

# Build

if [ ! -f "/srv/project/package.json" ]; then
  echo "package.json missing exiting"
  exit 0
fi

rm /usr/local/bin/build-android-* || true
ln -s /srv/config/build_scripts/build-android-dev.sh /usr/local/bin/build-android-dev
ln -s /srv/config/build_scripts/build-android-prod.sh /usr/local/bin/build-android-prod
ln -s /srv/config/build_scripts/build-android-release.sh /usr/local/bin/build-android-release

npm install -g ionic@3.1.2 cordova@7.0.1
cordova telemetry off
cd /srv/project
ls -lah package.json
npm install

# Fix babili bug:
find ./node_modules/@ionic/app-scripts/dist/babili.js -type f -exec sed -i 's/IONIC_USE_EXPERIMENTAL_BABILI/IONIC_BABILI/;s/ionic_use_experimental_babili/ionic_babili/' {} \;
