#!/bin/bash -v

set -e


cd /srv/project
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"
export LC_ALL=C.UTF-8
ionic build --prod
