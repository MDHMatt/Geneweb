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
RUN ./install.sh
RUN opam init
RUN eval $(opam env)
RUN opam install camlp5 cppo dune.1.11.4 markup stdlib-shims num zarith uucp unidecode

RUN adduser --system --group --home /usr/local/share/geneweb --shell /bin/bash geneweb
RUN chown -R geneweb:geneweb /usr/local/share/geneweb
