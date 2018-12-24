default-jre:
  pkg:
    - installed
curl:
  pkg:
    - installed
unzip:
  pkg:
    - installed
zip:
  pkg:
    - installed
wget:
  pkg:
    - installed
default-jdk:
  pkg:
    - installed
expect:
  pkg:
    - installed
git:
  pkg:
    - installed
ruby:
  pkg:
    - installed
build-essential:
  pkg:
    - installed

install gradle:
  cmd.run:
    -
      name: "/srv/config/gradle/gradle_setup.sh >> /var/log/gradle_setup.log 2>&1"
      stateful: True
      require:
          - pkg: curl
          - pkg: default-jre
          - pkg: default-jdk
          - pkg: unzip
          - pkg: zip
          - pkg: expect
          - pkg: build-essential
prepare ionic:
  cmd.run:
    -
      name: "/srv/config/ionic/prepare.sh >> /var/log/prepare_ionic.log 2>&1"
      stateful: True
      require:
          - pkg: curl
          - pkg: default-jre
          - pkg: default-jdk
          - pkg: unzip
          - pkg: zip
          - pkg: expect

run ionic:
  cmd.run:
    -
      name: "/srv/config/ionic/run.sh >> /var/log/ionic-serve.log 2>&1"
      bg: True
      stateful: True
      require:
          - pkg: curl
          - pkg: default-jre
          - pkg: default-jdk
          - pkg: unzip
          - pkg: zip
          - pkg: expect
