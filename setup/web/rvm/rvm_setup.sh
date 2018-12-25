#!/bin/bash -v

set -e

# install rvm
if [ ! -f /etc/profile.d/rvm.sh ]; then
  gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	cd /tmp
	curl -sSL https://get.rvm.io | bash
fi

# activate it for the user web
source /etc/profile.d/rvm.sh

# use rvm to install project specifics:
cd /srv/project
rvm install `cat .ruby-version`
cd /
cd /srv/project
gem install bundler
bundle install --without heroku_production_server heroku_production_db production
