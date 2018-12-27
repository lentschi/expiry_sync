#!/bin/bash -e

NODE_VERSION="10.15.0"
NPM_VERSION="6.4.1"

if [ ! -d "/home/web/n" ]; then
  cd /tmp
  curl -L https://git.io/n-install | bash -s -- -q

  echo 'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).' >> /home/web/.bashrc
  export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

  n "$NODE_VERSION"
  npm i -g "npm@$NPM_VERSION"

  sudo setcap CAP_NET_BIND_SERVICE=+eip /home/web/n/bin/node
  npm install -g ionic@4.6.0 cordova@8.1.2
  cordova telemetry off
fi

sudo ln -s /srv/config/restart.sh /usr/local/bin/restart-server