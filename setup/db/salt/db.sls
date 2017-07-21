git:
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
postgresql:
  pkg:
    - installed
  service.running:
    - name: postgresql
    - enable: True
postgresql-contrib:
  pkg:
    - installed
libxslt1-dev:
  pkg:
    - installed
sudo:
  pkg:
    - installed

setup db:
  cmd.run:
    -
      name: "/srv/config/postgresql/db.sh >> /var/log/db.log 2>&1"
      require:
        - pkg: postgresql
        - pkg: sudo
