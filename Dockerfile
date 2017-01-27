FROM alpine:latest
MAINTAINER Rafal Proszowski <paroxp@gmail.com>

# ENV VAULT_VERSION 0.6.1

RUN apk update && apk add --no-cache \
    python \
    python-dev \
    py-pip \
    libffi-dev \
    build-base \
    openssl-dev \
    jq \
    bash

RUN pip install credstash

ADD assets/ /opt/resource/
RUN chmod +x /opt/resource/*
