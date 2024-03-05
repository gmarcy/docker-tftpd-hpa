FROM alpine:3.19

# set version label
ARG BUILD_DATE
ARG VERSION

LABEL build_version="tftpd-hpa version: ${VERSION} Build-date: ${BUILD_DATE}"
LABEL maintainer="gmarcy"
LABEL org.opencontainers.image.description alpine image with tftpd-hpa installed

RUN \
 apk add --no-cache \
   bash \
   busybox \
   curl \
   shadow \
   sudo \
   supervisor \
   syslog-ng \
   tftp-hpa && \
 groupmod -g 1000 users && \
 useradd -u 911 -U -d /config -s /bin/false tftpd && \
 usermod -G users tftpd && \
 mkdir -p /var/lib/tftpboot/ipxe && \
 chown -R tftpd:tftpd /var/lib/tftpboot

ENV TFTPD_OPTS=''

EXPOSE 69/udp

COPY root/ /

# default command
CMD ["sh","/start.sh"]
