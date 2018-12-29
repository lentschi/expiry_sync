git:
  pkg:
    - installed
curl:
  pkg:
    - installed
g++:
  pkg:
    - installed
iproute:
  pkg:
    - installed
libxml2:
  pkg:
    - installed
libxml2-dev:
  pkg:
    - installed
libxslt1-dev:
  pkg:
    - installed
nodejs:
  pkg:
    - installed
libmysqlclient-dev:
  pkg:
    - installed
sudo:
  pkg:
    - installed
libmagickwand-dev:
  pkg:
    - installed
imagemagick:
  pkg:
    - installed

install rvm:
  cmd.run:
    -
      name: "/srv/config/rvm/rvm_setup.sh >> /var/log/rvm_setup.log 2>&1"
      stateful: True
      require:
          - pkg: curl
          - pkg: git
          - pkg: g++
          - pkg: iproute
          - pkg: libxslt1-dev
          - pkg: libxml2
          - pkg: libxml2-dev
          - pkg: libmysqlclient-dev
          - pkg: libmagickwand-dev 
          - pkg: imagemagick
          
run rails:
  cmd.run:
    -
      name: "/srv/config/rails/run_rails.sh >> /var/log/rails.log 2>&1"
      require:
        - pkg: nodejs
