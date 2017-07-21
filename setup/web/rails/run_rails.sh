#!/bin/bash -ve


if [ -z "$DOCKER_RUNNING" ]; then
  echo "run_rails.sh: cannot be installed during build as postgresql won't be available"
  exit 1
fi

source /etc/profile.d/rvm.sh
cd /srv/project
rvm install `cat .ruby-version`
cd /
cd /srv/project
gem install bundler
bundle install --without heroku_production_server heroku_production_db production

rm /srv/project/config/database.yml || true
ln -s /srv/config/rails/database.yml /srv/project/config/database.yml
rm /srv/project/config/initializers/mail.rb || true
ln -s /srv/config/rails/mail.rb /srv/project/config/initializers/mail.rb

bundle exec rake db:migrate || bundle exec rake db:setup && bundle exec rake db:migrate

EMAIL_LINK_HOST="expiry-sync-web.local" bundle exec rails s -p 80 -d
