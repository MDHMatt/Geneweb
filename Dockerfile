FROM debian:stable-slim
LABEL maintainer="MDHMatt <dev@mdhosting.co.uk>"

# Install required packages
RUN set -eux; \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -qq && \
    apt-get install -yq --no-install-recommends \
      apt-transport-https ca-certificates less nano tzdata libatomic1 vim wget libncurses5-dev build-essential coreutils curl make m4 unzip bubblewrap gcc libgmp-dev \
      pkg-config libgmp-dev libperl-dev libipc-system-simple-perl libstring-shellquote-perl git subversion mercurial rsync libcurl4-openssl-dev musl-dev \
      redis protobuf-compiler opam rsyslog
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Remove MOTD
RUN rm -rf /etc/update-motd.d /etc/motd /etc/motd.dynamic && \
    ln -fs /dev/null /run/motd.dynamic

RUN wget https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh && chmod +x install.sh && yes "" | sh ./install.sh

RUN rm -rf /usr/local/share/geneweb && \
    mkdir -p /usr/local/share/geneweb && \
    adduser --system --group --home /usr/local/share/geneweb --shell /bin/bash geneweb && \
    chown -R geneweb:geneweb /usr/local/share/geneweb

# create user
USER geneweb:geneweb
WORKDIR /usr/local/share/geneweb
RUN mkdir etc bin log tmp && \
    mkdir -p share/redis

# Setup build enviroment
ENV OPAM_VERSION="4.11.1"

RUN opam init -y --disable-sandboxing && \
 eval $(opam env) && opam update -a -y && \
 eval $(opam env) && opam upgrade -a -y && \
 eval $(opam env) && opam switch create "$OPAM_VERSION" && \
 eval $(opam env) && opam install -y --unlock-base camlp5 cppo dune jingoo markup ounit uucp uunf unidecode ocurl piqi piqilib redis redis-sync yojson calendars syslog && \
 eval $(opam env)

# Grab latest version of geneweb git files
WORKDIR "/usr/local/share/geneweb/.opam/$OPAM_VERSION/.opam-switch/build"
RUN git clone https://github.com/geneweb/geneweb geneweb

# Configure and build
WORKDIR "/usr/local/share/geneweb/.opam/$OPAM_VERSION/.opam-switch/build/geneweb"
RUN eval $(opam env) && ocaml ./configure.ml --api && make clean distrib

# Switch to root and copy built distrobution files to tmp for archive
USER root
RUN cp -r distribution /tmp/geneweb && cd /tmp/ && tar -czvf geneweb.tar.gz /tmp/geneweb  && ls -sl

WORKDIR "/tmp/"
# make temp git holding folder
#RUN mkdir gitpush && cd gitpush
#compiles to here ^^^^

# Grab git files and move archive into git and push to git
#RUN git clone https://github.com/MDHMatt/Geneweb.git && cd Geneweb && \
#    mv /tmp/geneweb.tar.gz /tmp/gitpush/Geneweb/geneweb.tar.gz && \
#    git add /tmp/gitpush/Geneweb/geneweb.tar.gz && \
#    git commit -m "Updated build files" && \
#    git push origin main



#WORKDIR /usr/local/share/geneweb
#RUN mv share/dist/bases share/data
#ADD gwsetup_only etc/gwsetup_only
#ADD geneweb-launch.sh bin/geneweb-launch.sh
#ADD redis.conf /etc/redis.conf

#USER root
#ENTRYPOINT bin/geneweb-launch.sh >/dev/null 2>&1

#EXPOSE 2316-2317
#EXPOSE 2322
