FROM alpine:latest
LABEL maintainer="MDHMatt <dev@mdhosting.co.uk>"

# Install required packages
RUN apk update && apk add wget p7zip
RUN wget https://github.com/MDHMatt/Geneweb/raw/main/geneweb.7z && \
    7z u geneweb.7z && cd geneweb

RUN sh ./gwsetup




#USER root
#ENTRYPOINT bin/geneweb-launch.sh >/dev/null 2>&1

EXPOSE 2316-2317
EXPOSE 2322
