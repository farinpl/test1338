FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive

# inspired by https://hub.docker.com/r/buanet/iobroker/

RUN apt-get update && apt-get install -y build-essential python apt-utils curl git libpcap-dev libavahi-compat-libdnssd-dev libfontconfig gnupg2 locales procps libudev-dev unzip sudo wget

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
RUN apt-get install -y nodejs


RUN mkdir -p /opt/iobroker/
WORKDIR /opt/iobroker/
RUN npm install iobroker --unsafe-perm && echo $(hostname) > .install_host
ADD scripts/run.sh run.sh
RUN chmod +x run.sh
VOLUME /opt/iobroker/


EXPOSE 8081
CMD /opt/iobroker/run.sh

ENV DEBIAN_FRONTEND teletype
