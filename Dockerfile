FROM ubuntu:16.04
MAINTAINER Makersphere Labs <opensource@makersphere.org>


RUN apt-get update && apt-get install -y \
clang \
curl \
git \
libsqlite3-dev \
make \
ruby-ronn \
sqlite3 \
nginx \
&& rm -rf /var/lib/apt/lists/*

ENV ZEROTIER_VERSION 1.2.0

RUN mkdir -p /app/source \
&& cd /app/source && git clone https://github.com/zerotier/ZeroTierOne.git \
&& cd /app/source/ZeroTierOne && git checkout tags/$ZEROTIER_VERSION \
&& cd /app/source/ZeroTierOne \
&& make ZT_ENABLE_NETWORK_CONTROLLER=1 \
&& sed -i -e 's/CFLAGS?=-O3 -fstack-protector/CFLAGS?=-O3 #-fstack-protector-strong/g' /app/source/ZeroTierOne/make-linux.mk \
&& sed -i -e 's/CXXFLAGS?=-O3 -fstack-protector/CXXFLAGS?=-O3 #-fstack-protector-strong/g' /app/source/ZeroTierOne/make-linux.mk \
&& cd /app/source/ZeroTierOne \
&& make install \
&& rm -rf /app/source \
&& apt-get remove -y \
clang \
git \
make

COPY ./run/start.sh /app/start.sh
COPY ./src/bin/app.sh /usr/sbin/zerotier-ctl
COPY ./src/controller.conf ./etc/nginx/sites-enabled/controller.conf

RUN chmod +x /app/start.sh \
&& chmod +x /usr/sbin/zerotier-ctl \
&& ln /usr/sbin/zerotier-ctl /var/lib/zerotier-one/zerotier-ctl

WORKDIR /var/lib/zerotier-one

EXPOSE 9993 80
CMD ["/app/start.sh"]
