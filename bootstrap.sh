#!/usr/bin/env bash
#!/
apt-get update
apt-get upgrade
apt-get install -y build-essential aptitude
apt-get install -y make cmake
aptitude install -y libmicrohttpd-dev libjansson-dev libnice-dev libssl-dev libsofia-sip-ua-dev libglib2.0-dev
aptitude install -y libopus-dev libogg-dev libcurl4-openssl-dev pkg-config gengetopt libtool automake git

# libsrtp
cd /tmp/ && wget https://github.com/cisco/libsrtp/archive/v1.5.4.tar.gz
tar xfv v1.5.4.tar.gz && cd libsrtp-1.5.4
./configure --prefix=/usr --enable-openssl
make shared_library && sudo make install

# usrsctp
cd /tmp/ && git clone https://github.com/sctplab/usrsctp
cd usrsctp && ./bootstrap
./configure --prefix=/usr --libdir=/usr/lib64 && make && sudo make install

# libwebsockerts
cd /tmp/ && git clone git://git.libwebsockets.org/libwebsockets
cd libwebsockets && git checkout v1.5-chrome47-firefox41
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_C_FLAGS="-fpic" ..
make && sudo make install

# MQTT
cd /tmp/ && git clone https://github.com/eclipse/paho.mqtt.c.git
cd paho.mqtt.c && make && sudo prefix=/usr make install

# RabbitMQ
cd /tmp/ && git clone https://github.com/alanxz/rabbitmq-c
cd rabbitmq-c && git submodule init && git submodule update
autoreconf -i && ./configure --prefix=/usr --libdir=/usr/lib64 && make && sudo make install

# Docs
aptitude -y install doxygen graphviz

# Exporting LD_LIBRARY_PATH (64bit)
LD_LIBRARY_PATH="/usr/lib64"
export LD_LIBRARY_PATH

# Janus
cd / && git clone https://github.com/meetecho/janus-gateway.git
cd janus-gateway
sh autogen.sh
./configure --prefix=/opt/janus --enable-docs
make
make install
make configs

# Apache2
apt-get -y install apache2
cp -R /janus-gateway/html/* /var/www/html/

# Janus as a Service
wget https://raw.githubusercontent.com/oscarvadillog/vagrant-janus-debian/master/janus.service -O /etc/init.d/janus
chmod +x /etc/init.d/janus
update-rc.d janus defaults
service janus start
