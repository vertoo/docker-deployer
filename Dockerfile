FROM php:7.2-alpine

MAINTAINER Grzegorz Gąsak <info@vertoo.pl>

ENV VERSION=6.4.3 
ARG USER_ID=1000

RUN apk update --no-cache \
    && apk add --no-cache \
        openssh-client

RUN addgroup -S deployer \
    && adduser -D -S -u $USER_ID -G deployer deployer \
    && mkdir -p /home/deployer/.ssh

RUN echo "Host *" >> /home/deployer/.ssh/config \
    && echo "  StrictHostKeyChecking=no" >> /home/deployer/.ssh/config \
    && chown -R deployer:deployer /home/deployer/.ssh \
    && chmod 600 /home/deployer/.ssh/config

RUN curl -L https://deployer.org/releases/v$VERSION/deployer.phar > /usr/local/bin/dep \
    && chmod +x /usr/local/bin/dep

USER deployer

VOLUME ["/app", "$HOME/.ssh/id_rsa"]

WORKDIR /app

ENTRYPOINT ["/usr/local/bin/dep"]
