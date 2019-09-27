FROM alpine:latest
MAINTAINER Karim Heraud <kheraud@gmail.com>

ARG PUBSUBBEAT_VERSION=1.1.0

RUN apk add --no-cache ca-certificates libc6-compat su-exec

WORKDIR /opt

ADD https://github.com/GoogleCloudPlatform/pubsubbeat/releases/download/${PUBSUBBEAT_VERSION}/pubsubbeat-linux-amd64.tar.gz \
    pubsubbeat-linux-amd64.tgz

RUN tar xvzf pubsubbeat-linux-amd64.tgz && \
    rm pubsubbeat-linux-amd64.tgz && \
    mv pubsubbeat-linux-amd64 gcp-pubsub-beat && \
    mkdir /usr/share/pubsubbeat && \
    chmod -R 755 /usr/share/pubsubbeat

COPY entrypoint.sh /opt/

VOLUME /usr/share/pubsubbeat

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["-c","/usr/share/pubsubbeat/pubsubbeat.yml"]
