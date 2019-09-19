export ANDROID_HOME=/opt/android-sdk-linux
export ANDROID_SDK=/opt/android-sdk-linux
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
#export JAVA_OPTS="--add-modules java.xml.bind"
export PATH="$PATH:/opt/android-sdk-linux/tools/bin"
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"