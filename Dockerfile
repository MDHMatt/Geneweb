FROM debian:stable
LABEL maintainer="MDHMatt <dev@mdhosting.co.uk>"

# Install required packages
RUN set -eux; \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -qq && \
    apt-get install -yq --no-install-recommends \
      apt-transport-https ca-certificates less nano tzdata libatomic1 vim wget libncurses5-dev build-essential coreutils curl make m4 unzip bubblewrap gcc libgmp-dev \
      pkg-config libgmp-dev libperl-dev libipc-system-simple-perl libstring-shellquote-perl git subversion mercurial rsync libcurl4-openssl-dev musl-dev \
      redis protobuf-compiler opam rsyslog
RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*
# Remove MOTD
RUN rm -rf /etc/update-motd.d /etc/motd /etc/motd.dynamic \
    && ln -fs /dev/null /run/motd.dynamic

RUN wget https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh
RUN chmod +x install.sh
RUN yes "" | sh ./install.sh

RUN rm -rf /usr/local/share/geneweb
RUN mkdir -p /usr/local/share/geneweb
RUN adduser --system --group --home /usr/local/share/geneweb --shell /bin/bash geneweb
RUN chown -R geneweb:geneweb /usr/local/share/geneweb

#compiles to here

USER geneweb:geneweb
WORKDIR /usr/local/share/geneweb
RUN mkdir etc bin log tmp && \
    mkdir -p share/redis && \
    
ENV OPAM_VERSION="4.11.1"

RUN opam init -y --disable-sandboxing && \
 eval $(opam env) && opam update -a -y && \
 eval $(opam env) && opam upgrade -a -y && \
 eval $(opam env) && opam switch create "$OPAM_VERSION" && \
 eval $(opam env) && opam install -y --unlock-base camlp5.7.13 cppo dune jingoo markup ounit uucp uunf unidecode ocurl piqi piqilib redis redis-sync yojson calendars syslog
 
 
# RUN opam init
# RUN eval $(opam env)
# RUN opam install ocaml-base-compiler camlp5 cppo dune.1.11.4 markup stdlib-shims num zarith uucp unidecode

