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

RUN mkdir /geneweb
#RUN useradd geneweb &&
#RUN chown -R geneweb:geneweb /home/geneweb
#USER geneweb:geneweb

# Set container work dir
WORKDIR /geneweb

# Copy from repo, extract, set perms and remove archive.
COPY ./geneweb.7z /geneweb/
COPY ./geneweb.sh /geneweb/
RUN 7z x geneweb.7z -y && chmod -R u=rwx,go=rx /geneweb && rm geneweb.7z

# Open ports
EXPOSE 2316-2317
EXPOSE 2322

# Start watchdog and services
#RUN sh ./geneweb/genweb.sh
ENTRYPOINT sh ./geneweb/genweb.sh
