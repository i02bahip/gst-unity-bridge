cd /home
sudo git clone https://github.com/i02bahip/gst-unity-bridge.git
sudo chmod -R 777 gst-unity-bridge/
sudo apt-get update && apt-get -y install build-essential pkg-config wget unzip file
sudo wget https://dl.google.com/android/repository/android-ndk-r21b-linux-x86_64.zip
sudo unzip -q android-ndk-r21b-linux-x86_64.zip -d /usr/local/
sudo rm android-ndk-r21b-linux-x86_64.zip
sudo wget http://archive.apache.org/dist/ant/binaries/apache-ant-1.9.4-bin.tar.gz
sudo tar -xzf apache-ant-1.9.4-bin.tar.gz
sudo mv apache-ant-1.9.4 /opt/ant
sudo rm apache-ant-1.9.4-bin.tar.gz
export PATH=${PATH}:/opt/ant/bin
sudo wget https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
sudo tar -xzf android-sdk_r24.4.1-linux.tgz -C /usr/local
sudo rm  android-sdk_r24.4.1-linux.tgz
cd /usr/local/android-sdk-linux/tools
sudo ./android update sdk --no-ui -a --filter 1,2,3,4,android-23
cd /home
sudo wget https://gstreamer.freedesktop.org/data/pkg/android/1.16.2/gstreamer-1.0-android-universal-1.16.2.tar.xz
sudo mkdir -p /usr/local/gstreamer
sudo tar -Jxvf gstreamer-1.0-android-universal-1.16.2.tar.xz -C /usr/local/gstreamer
sudo rm gstreamer-1.0-android-universal-1.16.2.tar.xz
sudo sed -i -e 's/#define GST_GL_HAVE_GLSYNC 0/#define GST_GL_HAVE_GLSYNC 1/g' /usr/local/gstreamer/armv7/lib/gstreamer-1.0/include/gst/gl/gstglconfig.h
sudo sed -i -e 's/#define GST_GL_HAVE_GLUINT64 0/#define GST_GL_HAVE_GLUINT64 1/g' /usr/local/gstreamer/armv7/lib/gstreamer-1.0/include/gst/gl/gstglconfig.h
sudo sed -i -e 's/#define GST_GL_HAVE_GLINT64 0/#define GST_GL_HAVE_GLINT64 1/g' /usr/local/gstreamer/armv7/lib/gstreamer-1.0/include/gst/gl/gstglconfig.h
sudo cp /usr/local/gstreamer/armv7/lib/gstreamer-1.0/include/gst/gl/gstglconfig.h /usr/local/gstreamer/armv7/include/gstreamer-1.0/gst/gl/
cd /home/gst-unity-bridge/Plugin/GUB/Project/Android/GUB
export PATH=${PATH}:/usr/local/android-sdk-linux/tools
export PATH=${PATH}:/usr/local/android-sdk-linux/platform-tools
android update project -p . -s --target android-23
export GSTREAMER_ROOT_ANDROID=/usr/local/gstreamer/armv7
export PATH=${PATH}:/usr/local/android-ndk-r21b
ndk-build APP_ABI=armeabi-v7a
cd src
jar cvf gub.jar org/*
