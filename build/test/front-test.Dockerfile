FROM debian:jessie
RUN apt-get update && apt-get install -y git-core
RUN apt-get -y install          \
    libcapture-tiny-perl        \
    libcommon-sense-perl        \
    libdata-dumper-simple-perl  \
    libdbd-pg-perl              \
    libdbi-perl                 \
    libdigest-perl              \
    libgd-perl                  \
    libgeo-ip-perl              \
    libhtml-parser-perl         \
    libhtml-template-perl       \
    libjson-perl                \
    libjson-xs-perl             \
    libnetaddr-ip-perl          \
    libnet-cidr-perl            \
    libnet-ip-perl              \
    libnet-oping-perl           \
    libnet-rawip-perl           \
    libsnmp-perl                \
    libsocket6-perl             \
    libsocket-perl              \
    libswitch-perl              \
    libtimedate-perl            \
    perl                        \
    perl-base                   \
    perl-modules                \
    libfreezethaw-perl		\
    apache2

RUN git clone https://github.com/tech-server/tgnms /opt/nms

RUN a2dissite 000-default
RUN a2enmod cgi
RUN cp /opt/nms/extras/misc/apache2.conf /etc/apache2/sites-enabled/nms.conf
RUN mkdir -p /opt/nms/etc
RUN echo 'demo:$apr1$IKrQYF6x$0zmRciLR7Clc2tEEosyHV.' > /opt/nms/etc/htpasswd-read
RUN echo 'demo:$apr1$IKrQYF6x$0zmRciLR7Clc2tEEosyHV.' > /opt/nms/etc/htpasswd-write
ADD test/dummy-apache2.start /
RUN chmod 0755 /dummy-apache2.start
CMD /dummy-apache2.start