#!/bin/bash -e

NODE_VERSION="10.16.2"
NPM_VERSION="6.9.0"

if [ ! -d "/home/web/n" ]; then
  cd /tmp
  curl -L https://git.io/n-install | bash -s -- -q

  echo 'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).' >> /home/web/.bashrc
  export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

  n "$NODE_VERSION"
  npm i -g "npm@$NPM_VERSION"

  sudo setcap CAP_NET_BIND_SERVICE=+eip /home/web/n/bin/node
  npm install -g ionic@5.2.4 cordova@9.0.0 native-run@0.2.8 cordova-res@0.6.0
  cordova telemetry off
fi

sudo ln -s /srv/config/restart.sh /usr/local/bin/restart-server