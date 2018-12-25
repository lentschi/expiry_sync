#!/bin/bash -e

NODE_VERSION="8.9.4"
NPM_VERSION="5.5.1"
ANGULAR_CLI_VERSION="1.6.8"

if [ ! -d "/home/web/n" ]; then
  cd /tmp
  curl -L https://git.io/n-install | bash -s -- -q

  echo 'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).' >> /home/web/.bashrc
  export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

  n "$NODE_VERSION"
  npm i -g "npm@$NPM_VERSION"
  npm i -g "@angular/cli@$ANGULAR_CLI_VERSION"

  sudo setcap CAP_NET_BIND_SERVICE=+eip /home/web/n/bin/node
fi

sudo ln -s /srv/config/restart.sh /usr/local/bin/restart-server
