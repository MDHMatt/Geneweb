FROM debian:stable-slim
LABEL maintainer="MDHMatt <dev@mdhosting.co.uk>"

ENV OPAM_VERSION="4.11.1"

# update all the things and install requirements
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update -q && \
    apt-get install -yq curl wget make m4 pkg-config unzip git bubblewrap gcc libgmp-dev

RUN wget https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh && chmod +x install.sh && yes "" | sh ./install.sh

# compile opam and camlp5
RUN opam init -y --disable-sandboxing && \
    eval $(opam env) && opam update -a -y && \
    eval $(opam env) && opam upgrade -a -y && \
    opam install camlp5 cppo dune.1.11.4 markup stdlib-shims num zarith uucp unidecode

# Remove MOTD
# RUN rm -rf /etc/update-motd.d /etc/motd /etc/motd.dynamic \
#    && ln -fs /dev/null /run/motd.dynamic

# create geneweb user. Make sure dire dosent exist already, change ownership
RUN rm -rf /usr/local/share/geneweb && \
 mkdir -p /usr/local/share/geneweb && \
 adduser --system --group --home /usr/local/share/geneweb --shell /bin/bash geneweb && \
 chown -R geneweb:geneweb /usr/local/share/geneweb

# switch to user and folder
USER geneweb:geneweb
WORKDIR /usr/local/share/geneweb

#clone from github and make
RUN git clone https://github.com/geneweb/geneweb && \
    cd geneweb && \
    ocaml ./configure.ml --api && make clean distrib


#WORKDIR /usr/local/share/geneweb
#RUN mv share/dist/bases share/data
#ADD gwsetup_only etc/gwsetup_only
#ADD geneweb-launch.sh bin/geneweb-launch.sh
#ADD redis.conf /etc/redis.conf

#USER root
#ENTRYPOINT bin/geneweb-launch.sh >/dev/null 2>&1

# ports to pass to docker and system
EXPOSE 2316-2317
EXPOSE 2322
