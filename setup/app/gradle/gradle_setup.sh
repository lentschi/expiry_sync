#!/bin/bash -ve

rm /etc/profile.d/android.sh || true
sudo ln -s /srv/config/gradle/android.sh /etc/profile.d
chown root:root /etc/profile.d/android.sh
source /etc/profile.d/android.sh

if [ ! -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
  curl -s "https://get.sdkman.io" | bash
fi

source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install gradle 4.10.3

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
  spawn sdkmanager --install "platforms;android-27";
  expect {
      "Accept? (y/N)" { exp_send "y\r" ; exp_continue }
      eof
  }
  '

  # install build tools:
  sdkmanager --install "build-tools;26.0.2"
  sdkmanager --install "platform-tools"
  sdkmanager --install "system-images;android-27;google_apis;x86"

  chgrp web /opt/android-sdk-linux -R
  chmod g+rw /opt/android-sdk-linux -R
  find /opt/android-sdk-linux -executable -type f -exec chmod g+x {} \;
fi
