FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

# inspired by https://hub.docker.com/r/buanet/iobroker/

RUN apt-get update && apt-get install -y build-essential python apt-utils curl openssh git libpcap-dev libavahi-compat-libdnssd-dev libfontconfig gnupg2 locales procps libudev-dev unzip sudo wget

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
RUN apt-get install -y nodejs

ENV LANG de_DE.UTF-8 
RUN cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime

RUN mkdir -p /opt/iobroker/ && chmod 777 /opt/iobroker/
RUN mkdir -p /opt/scripts/ && chmod 777 /opt/scripts/

ADD scripts/iobroker_startup.sh iobroker_startup.sh
RUN chmod +x iobroker_startup.sh

WORKDIR /opt/iobroker/

RUN npm install iobroker --unsafe-perm && echo $(hostname) > .install_host
RUN update-rc.d iobroker.sh remove
RUN npm install node-gyp -g

EXPOSE 8081

CMD ["sh", "/opt/scripts/iobroker_startup.sh"]

ENV DEBIAN_FRONTEND teletype
