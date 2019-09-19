#!/bin/bash -e

source /home/web/.rvm/scripts/rvm

set -v
cd /srv/project
bundle install --without heroku production --with local_docker_compose

rm /srv/project/config/database.yml || true
ln -s /srv/config/rails/database.yml /srv/project/config/database.yml
rm /srv/project/config/initializers/mail.rb || true
ln -s /srv/config/rails/mail.rb /srv/project/config/initializers/mail.rb

bundle exec rake db:migrate || bundle exec rake db:setup && bundle exec rake db:migrate

EMAIL_LINK_HOST="expiry-sync-web.local" authbind --deep bundle exec thin start --ssl --ssl-cert-file /srv/config/cert/expirysync_server.crt --ssl-key-file /srv/config/cert/expirysync_server.cert.key --port 443
