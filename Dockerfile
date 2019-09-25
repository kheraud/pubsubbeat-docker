FROM alpine:latest
MAINTAINER Karim Heraud <kheraud@gmail.com>

ARG PUBSUBBEAT_VERSION=1.1.0

RUN apk add --no-cache ca-certificates libc6-compat

WORKDIR /opt

ADD https://github.com/GoogleCloudPlatform/pubsubbeat/releases/download/${PUBSUBBEAT_VERSION}/pubsubbeat-linux-amd64.tar.gz \
    pubsubbeat-linux-amd64.tgz

RUN tar xvzf pubsubbeat-linux-amd64.tgz && \
    rm pubsubbeat-linux-amd64.tgz && \
    mv pubsubbeat-linux-amd64 gcp-pubsub-beat

RUN addgroup -g 1001 pubsubuser && \
    adduser -D -H -G pubsubuser -u 1001 pubsubuser -s /bin/bash

RUN chown -R pubsubuser:pubsubuser /opt/gcp-pubsub-beat

USER pubsubuser

ENTRYPOINT /opt/gcp-pubsub-beat/pubsubbeat
