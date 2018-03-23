FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive

# inspired by https://hub.docker.com/r/buanet/iobroker/
# inspired by https://hub.docker.com/r/diggewuff/fhem-docker

RUN \

apt-get update \
&& apt-get -qqy dist-upgrade \

&& apt-get install -y build-essential \
python \
apt-utils \
curl \
git \
libpcap-dev \
libavahi-compat-libdnssd-dev \
libfontconfig \
gnupg2 \
locales \
procps \
libudev-dev \
unzip \
sudo \
wget \
net-tools \
vim \
screenfetch 
 

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
RUN apt-get install -y nodejs

## Customize console
RUN echo "alias ll='ls -lah --color=auto'" >> /root/.bashrc \
    && echo "screenfetch" >> /root/.bashrc


RUN mkdir -p /opt/iobroker/
WORKDIR /opt/iobroker/
RUN npm install iobroker --unsafe-perm && echo $(hostname) > .install_host
ADD scripts/run.sh run.sh
RUN chmod +x run.sh
VOLUME /opt/iobroker/


EXPOSE 8081
CMD /opt/iobroker/run.sh

ENV DEBIAN_FRONTEND teletype
