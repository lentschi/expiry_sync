FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

VOLUME /srv/project
VOLUME /srv/config

RUN apt-get update \
&& apt-get -y dist-upgrade \
&& apt install -y net-tools build-essential iproute2 git wget unzip bzip2 \
zip curl vim iputils-ping nmap sudo openjdk-8-jre openjdk-8-jdk expect \
ruby gnupg2 authbind

# backend packages for e2e testing:
RUN apt install -y ruby gnupg2 imagemagick libxml2 libxml2-dev libxslt1-dev \
libmagickwand-dev dbus-x11

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
&& echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
&& apt-get update \
&& apt-get install google-chrome-stable -y

ARG group_id
RUN groupadd -g ${group_id} web

ARG user_id
RUN useradd -g web -m -u ${user_id} web

RUN echo "web ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER web:web

RUN echo "alias tailf=\"tail -f\"" >> ~/.bash_aliases 

RUN mkdir ~/.gnupg
RUN echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf

ARG config_path
ADD ${config_path} /srv/config

ARG backend_path
ADD ${backend_path}/.ruby-version /srv/project/.ruby-version
ADD ${backend_path}/.ruby-gemset /srv/project/.ruby-gemset
ADD ${backend_path}/Gemfile /srv/project/Gemfile
ADD ${backend_path}/Gemfile.lock /srv/project/Gemfile.lock

ARG backend_config
ADD ${backend_config} /srv/web_config

RUN gpg --version
RUN /srv/web_config/rvm/rvm_setup.sh

RUN sudo /srv/config/gradle/gradle_setup.sh
RUN /srv/config/ionic/node_setup.sh

CMD /srv/config/ionic/run.sh >> /home/web/run.log 2>&1; tail -F /home/web/run.log