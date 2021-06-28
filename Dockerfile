FROM alpine:3.14
LABEL maintainer="MDHMatt <dev@mdhosting.co.uk>"

# Install required packages
RUN apk update && apk add m4 coreutils wget git p7zip nano bash dune opam perl-string-shellquote gcc make g++ zlib-dev build-base rsync perl tzdata subversion mercurial rsync libcurl openssl musl-dev

# Setup build enviroment and Opam modules
ARG OPAM_PACKAGES='camlp5 cppo dune jingoo markup ounit uucp uunf unidecode ocurl piqi piqilib redis redis-sync yojson calendars syslog'
ENV OPAM_VERSION="4.11.1"

RUN opam init -y --disable-sandboxing && \
 eval $(opam env) && opam update -a -y && \
 eval $(opam env) && opam upgrade -a -y && \
 eval $(opam env) && opam switch create "$OPAM_VERSION" && \
 eval $(opam env) && opam install -y --unlock-base "$OPAM_PACKAGES" && \
 eval $(opam env)

# Grab latest version of geneweb git files
#WORKDIR "/usr/local/share/geneweb/.opam/$OPAM_VERSION/.opam-switch/build"
#RUN git clone https://github.com/geneweb/geneweb geneweb

# Configure and build
#WORKDIR "/usr/local/share/geneweb/.opam/$OPAM_VERSION/.opam-switch/build/geneweb"
#RUN eval $(opam env) && ocaml ./configure.ml --api && make clean distrib

# Create a group and user
#RUN addgroup -S geneweb && adduser -S geneweb -G geneweb

# Tell docker that all future commands should run as the geneweb user
#USER geneweb
#WORKDIR /home/geneweb/

#RUN 7z a /home/geneweb/geneweb.7z  /usr/local/share/geneweb/.opam/$OPAM_VERSION/.opam-switch/build/geneweb/distribution/*

# Grab files and extract
#RUN wget https://github.com/MDHMatt/Geneweb/raw/main/geneweb.7z && 7z x geneweb.7z
#RUN cd /home/geneweb/geneweb

# Run application
#RUN sh ./home/geneweb/geneweb/gwsetup


#ENTRYPOINT bin/geneweb-launch.sh >/dev/null 2>&1

# Open ports
#EXPOSE 2316-2317
#EXPOSE 2322
