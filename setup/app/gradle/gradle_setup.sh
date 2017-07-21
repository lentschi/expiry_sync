#!/bin/bash -ve

rm /etc/profile.d/android.sh || true
ln -s /srv/config/gradle/android.sh /etc/profile.d
chown root:root /etc/profile.d/android.sh
source /etc/profile.d/android.sh

if [ ! -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  curl -s "https://get.sdkman.io" | bash
fi

source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install gradle 3.2

if [ ! -f "/usr/bin/npm" ]; then
  cd /tmp
  curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
  bash nodesource_setup.sh
  apt install nodejs -y
  npm i -g npm@4.6.1
fi

# Android SDK:
# s. http://stackoverflow.com/questions/17963508/how-to-install-android-sdk-build-tools-on-the-command-line
if [ ! -d /opt/android-sdk-linux ]; then
  mkdir -p /opt/android-sdk-linux && cd /opt/android-sdk-linux && \
    wget -q $(wget -q -O- 'https://developer.android.com/sdk' | \
    grep -o "\"https://.*android.*tools.*linux.*\"" | sed "s/\"//g") && \
    unzip *tools*linux*.zip && \
    rm *tools*linux*.zip

  # install sdk & accept license:
  expect -c '
  set timeout -1   ;
  spawn tools/bin/sdkmanager "platforms;android-25";
  expect {
      "Accept? (y/N)" { exp_send "y\r" ; exp_continue }
      eof
  }
  '

  # install build tools:
  tools/bin/sdkmanager "build-tools;26.0.0"
fi
