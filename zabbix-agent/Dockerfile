ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH
ARG BUILD_VERSION

LABEL maintainer "Philipp Schmitt <philipp@schmitt.co>"

ENV LANG C.UTF-8

# Install requirements for add-on
RUN apk add --no-cache jq zabbix-agent raspberrypi raspberrypi-libs usbutils

##
# Set symlinks for raspberry pi binaries.
RUN ln -sv /opt/vc/bin/raspistill /usr/local/bin/raspistill \
    && ln -sv /opt/vc/bin/raspivid /usr/local/bin/raspivid \
    && ln -sv /opt/vc/bin/raspividyuv /usr/local/bin/raspividyuv \
    && ln -sv /opt/vc/bin/raspiyuv /usr/local/bin/raspiyuv
# RUN /usr/sbin/usermod -a -G video zabbix

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

USER root

RUN echo http://dl-4.alpinelinux.org/alpine/v3.11/community/ >> /etc/apk/repositories && \
    apk add --no-cache shadow && \
    usermod -aG video zabbix
    
#shadow && usermod -aG video zabbix

CMD [ "/run.sh" ]

