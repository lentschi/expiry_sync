#!/bin/bash -e

NODE_VERSION="8.9.4"
NPM_VERSION="5.5.1"
ANGULAR_CLI_VERSION="1.6.8"

if [ ! -d "/root/n" ]; then
  cd /tmp
  curl -L https://git.io/n-install | bash -s -- -q

  echo 'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).' >> /root/.bashrc
  export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

  n "$NODE_VERSION"
  npm i -g "npm@$NPM_VERSION"
  npm i -g "@angular/cli@$ANGULAR_CLI_VERSION"
fi