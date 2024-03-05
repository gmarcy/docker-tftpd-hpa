# docker-tftpd-hpa

## Overview

The container is built upon Alpine Linux and contains several components:

* tftpd-hpa
* syslog for providing tftpd activity logs

Services are managed in the container by [supervisord](http://supervisord.org/).

The container runs fine under ARM-based hosts as well as x86-64.

## Usage

The tftpd-hpa docker image requires an existing DHCP server to be setup and running in order to boot from it. The image does not contain a DHCP server service. Please see the DHCP configuration setup near the end of this document for ideas on how to enable your environment to talk to the container. In most cases, you will need to specify the next-server and boot file name in the DHCP configuration. Your DHCP server will need to be assigned a static IP.

### Download the docker image

#### From Github Container Registry

```shell
docker pull ghcr.io/gmarcy/tftpd-hpa
```

The following snippets are examples of starting up the container.

### docker-cli

```shell
docker run -d \
  --name=tftpd-hpa \
  -p 69:69/udp                       `# sets tftpd port` \
  -v /local/path/to/tftpboot:/var/lib/tftpboot   `# optional` \
  --restart unless-stopped \
  ghcr.io/gmarcy/tftpd-hpa
```
