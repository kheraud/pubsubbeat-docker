# Pubsubbeat-docker

This repository contains a *Dockerfile* of [GCP pubsubbeat](https://github.com/GoogleCloudPlatform/pubsubbeat). It is made to *pull a GCP pubsub topic* to *feed elasticsearch/logstash*.

## Base Docker Image ##

* [alpine:latest](https://hub.docker.com/_/alpine)

## Installation ##

1. Install [Docker](https://www.docker.com)
2. Pull [automated build](https://hub.docker.com/r/kheraud/pubsubbeat/) from public [Docker Hub Registry](https://registry.hub.docker.com):
```
docker pull kheraud/pubsubbeat
```

Alternatively, you can build an image from Dockerfile:
```
docker build \
  --build-arg PUBSUBBEAT_VERSION="1.1.0" \
  -t kheraud/pubsubbeat \
  github.com/kheraud/pubsubbeat.git
```

## Usage ##
A pubsubbeat configuration file is expected at `/usr/share/pubsubbeat/pubsubbeat.yml`. See [original repository](https://github.com/GoogleCloudPlatform/pubsubbeat) for configuration : `pubsubbeat.reference.yml`.

You will also need to configure a google service account to access your target pubsub topic. It is adviced to put this file in `/usr/share/pubsubbeat/` directory also.

```
docker run kheraud/pubsubbeat \
  -v ./pubsubbeat-conf.yml:/usr/share/pubsubbeat/pubsubbeat.yml:ro \
  -v ./service-account.json:/usr/share/pubsubbeat/service-account.json:ro
```

### Non-root ###
The container is prepared to be used with a non-root user called `pubsubuser`. At launch, container automatically switch to this user thanks to [su exec](https://github.com/ncopa/su-exec).

## Contribution policy ##

Contributions via GitHub pull requests are gladly accepted from their original author. Along with any pull requests, please state that the contribution is your original work and that you license the work to the project under the project's open source license. Whether or not you state this explicitly, by submitting any copyrighted material via pull request, email, or other means you agree to license the material under the project's open source license and warrant that you have the legal authority to do so.


## License ##

This code is open source software licensed under the [Apache 2.0 License]("http://www.apache.org/licenses/LICENSE-2.0.html").
