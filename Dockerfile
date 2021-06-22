FROM debian:stable-slim
LABEL maintainer="MDHMatt <dev@mdhosting.co.uk>"

# Install required packages
RUN set -eux; \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -qq update && apt-get -qq upgrade && apt-get -qq install apt-transport-https ca-certificates less nano tzdata p7zip-full libatomic1 vim wget \
    libncurses5-dev wget tzdata p7zip-full pkg-config libgmp-dev libperl-dev libipc-system-simple-perl libstring-shellquote-perl git \
    subversion mercurial rsync libcurl4-openssl-dev musl-dev redis protobuf-compiler opam rsyslog && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Remove MOTD
RUN rm -rf /etc/update-motd.d /etc/motd /etc/motd.dynamic && ln -fs /dev/null /run/motd.dynamic

#RUN useradd geneweb &&

RUN mkdir /geneweb
VOLUME /geneweb
RUN cd geneweb && wget https://github.com/MDHMatt/Geneweb/raw/main/geneweb.7z && 7z x geneweb.7z -y && rm geneweb.7z && ls -slh

#RUN chown -R geneweb:geneweb /home/geneweb
#USER geneweb:geneweb
RUN wget https://github.com/MDHMatt/Geneweb/blob/c8901ca2abe2f2d3d38dfb9fbf16ec61c425c44c/geneweb.sh && chmod +x geneweb.sh

#RUN sh ./home/geneweb/gwsetup -lang en -daemon
#CMD sh ./home/geneweb/gwd -daemon
#CMD sh ./home/geneweb/geneweb.sh


EXPOSE 2316-2317
EXPOSE 2322
CMD sh ./genweb.sh
