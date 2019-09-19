#!/bin/bash -ve

source "/$HOME/.sdkman/bin/sdkman-init.sh"

echo no | /opt/android-sdk-linux/tools/bin/avdmanager create avd -n test -k "system-images;android-27;google_apis;x86"

cat >~/.android/avd/test.avd/config.ini <<EOF
PlayStore.enabled=false
abi.type=x86
avd.ini.encoding=UTF-8
disk.dataPartition.size=800M
fastboot.forceColdBoot=no
hw.accelerometer=yes
hw.arc=false
hw.audioInput=yes
hw.battery=yes
hw.camera.back=virtualscene
hw.camera.front=emulated
hw.cpu.arch=x86
hw.cpu.ncore=4
hw.dPad=no
hw.device.manufacturer=Google
hw.gps=yes
hw.gpu.enabled=yes
hw.gpu.mode=auto
hw.initialOrientation=Portrait
hw.keyboard=yes
hw.lcd.density=560
hw.lcd.height=2880
hw.lcd.width=1440
hw.mainKeys=no
hw.ramSize=1536
hw.sdCard=yes
hw.sensors.orientation=yes
hw.sensors.proximity=yes
hw.trackBall=no
image.sysdir.1=system-images/android-27/google_apis/x86/
runtime.network.latency=none
runtime.network.speed=full
sdcard.size=100M
showDeviceFrame=yes
tag.display=Google APIs
tag.id=google_apis
vm.heapSize=256
EOF