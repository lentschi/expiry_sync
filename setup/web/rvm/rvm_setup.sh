#!/bin/bash -ve

# install rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
cd /tmp
curl -sSL https://get.rvm.io | bash

# Allow ruby to serve on port 80 and 443:
sudo touch /etc/authbind/byport/80
sudo touch /etc/authbind/byport/443
sudo chmod 777 /etc/authbind/byport/80
sudo chmod 777 /etc/authbind/byport/443

source /home/web/.rvm/scripts/rvm

set -v
cd /srv/project
  rvm install `cat .ruby-version`
cd /
cd /srv/project
gem install bundler -v 1.17.3