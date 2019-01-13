FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

VOLUME /srv/project
VOLUME /srv/config

RUN apt-get update \
&& apt-get -y dist-upgrade \
&& apt install -y net-tools build-essential iproute2 git wget unzip bzip2 \
zip curl vim iputils-ping nmap sudo libxml2 libxml2-dev libxslt1-dev libpq-dev \
imagemagick libmagickwand-dev mysql-client libmysqlclient-dev authbind gnupg2

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

# RUN echo "alias tailf=\"tail -f\"" >> ~/.bash_aliases 
# RUN echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf

ARG config_path
ADD ${config_path} /srv/config

ARG project_path
ADD ${project_path}/.ruby-version /srv/project/.ruby-version
ADD ${project_path}/.ruby-gemset /srv/project/.ruby-gemset
ADD ${project_path}/Gemfile /srv/project/Gemfile
ADD ${project_path}/Gemfile.lock /srv/project/Gemfile.lock

RUN /srv/config/rvm/rvm_setup.sh

CMD /srv/config/rails/run_rails.sh >> /home/web/run.log 2>&1; tail -F /home/web/run.log