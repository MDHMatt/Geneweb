FROM alpine:latest
LABEL maintainer="MDHMatt <dev@mdhosting.co.uk>"

# Install required packages
RUN apk update && apk add wget p7zip nano

# Create a group and user
RUN addgroup -S geneweb && adduser -S geneweb -G geneweb

# Tell docker that all future commands should run as the geneweb user
USER geneweb
WORKDIR /home/geneweb/

# Grab files and extract
RUN wget https://github.com/MDHMatt/Geneweb/raw/main/geneweb.7z && 7z x geneweb.7z && cd geneweb

# Run application
RUN sh ./gwsetup


#ENTRYPOINT bin/geneweb-launch.sh >/dev/null 2>&1

# Open ports
EXPOSE 2316-2317
EXPOSE 2322
