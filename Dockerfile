FROM debian:stable-slim
LABEL maintainer="MDHMatt <dev@mdhosting.co.uk>"

RUN adduser --system --group --home /home/geneweb --shell /bin/bash geneweb
RUN mv geneweb.tar.gz /home/geneweb/geneweb.tar.gz && \
    cd /home/geneweb/ && tar -xf geneweb.tar.gz

WORKDIR /home/geneweb/
ADD https://github.com/MDHMatt/Geneweb/raw/main/geneweb.7z /home/geneweb/

# Install required packages
RUN set -eux; \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -qq && apt-get install -yq wget tzdata p7zip-full && apt-get upgrade -yq

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Remove MOTD
RUN rm -rf /etc/update-motd.d /etc/motd /etc/motd.dynamic && ln -fs /dev/null /run/motd.dynamic


RUN chown -R geneweb:geneweb /home/geneweb
USER geneweb:geneweb    
RUN sh ./home/geneweb/gwsetup -lang en -daemon
#CMD sh ./home/geneweb/gwd -daemon
#CMD sh ./home/geneweb/geneweb.sh

EXPOSE 2316-2317
EXPOSE 2322
