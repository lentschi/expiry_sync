#!/bin/bash -ve

# # Build

if [ ! -f "/srv/project/package.json" ]; then
  echo "package.json missing exiting"
  exit 0
fi

sudo rm /usr/local/bin/build-* || true
sudo ln -s /srv/config/build_scripts/build-android-dev.sh /usr/local/bin/build-android-dev
sudo ln -s /srv/config/build_scripts/build-android-prod.sh /usr/local/bin/build-android-prod
sudo ln -s /srv/config/build_scripts/build-android-release.sh /usr/local/bin/build-android-release
sudo ln -s /srv/config/build_scripts/build-android-new.sh /usr/local/bin/build-android-new
sudo ln -s /srv/config/build_scripts/build-web-release.sh /usr/local/bin/build-web-release

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
cd /srv/project
ls -lah package.json
sudo setcap CAP_NET_BIND_SERVICE=+eip /home/web/n/bin/node
npm install

# Fix babili bug:
#find ./node_modules/@ionic/app-scripts/dist/babili.js -type f -exec sed -i 's/IONIC_USE_EXPERIMENTAL_BABILI/IONIC_BABILI/;s/ionic_use_experimental_babili/ionic_babili/' {} \;

# Clear temporary testing files (in case the tests crashed during the previous run):
rm /tmp/*.pid || true
rm /tmp/test.sqlite3 || true
rm /srv/expiry_sync_server/db/test.sqlite3 || true