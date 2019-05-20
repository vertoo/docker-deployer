FROM php:7.2-alpine

MAINTAINER Grzegorz Gąsak <info@vertoo.pl>

ENV VERSION=6.4.3 
ARG USER_ID=1000

ARG INSTALL_NPM=false
ARG INSTALL_BOWER=false
ARG INSTALL_GULP=false
ARG INSTALL_VUE_CLI=false

RUN apk update --no-cache \
    && apk add --no-cache \
        openssh-client rsync

RUN addgroup -S deployer \
    && adduser -D -S -u $USER_ID -G deployer deployer \
    && mkdir -p /home/deployer/.ssh

RUN echo "Host *" >> /home/deployer/.ssh/config \
    && echo "  StrictHostKeyChecking=no" >> /home/deployer/.ssh/config \
    && chown -R deployer:deployer /home/deployer/.ssh \
    && chmod 600 /home/deployer/.ssh/config

RUN curl -L https://deployer.org/releases/v$VERSION/deployer.phar > /usr/local/bin/dep \
    && chmod +x /usr/local/bin/dep

RUN if [ ${INSTALL_NPM} = true ]; then \
    apk add --update nodejs nodejs-npm \
    && if [ ${INSTALL_BOWER} = true ]; then \
    npm install -g bower \
    ;fi \
    && if [ ${INSTALL_GULP} = true ]; then \
    npm install -g gulp \
    ;fi \
    && if [ ${INSTALL_GULP} = true ]; then \
    npm install -g @vue/cli \
    ;fi \
;fi    

USER deployer

VOLUME ["/app", "$HOME/.ssh/id_rsa"]

WORKDIR /app

ENTRYPOINT ["/usr/local/bin/dep"]
