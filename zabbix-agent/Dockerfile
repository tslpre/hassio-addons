ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH
ARG BUILD_VERSION

LABEL maintainer "Philipp Schmitt <philipp@schmitt.co>"

ENV LANG C.UTF-8

RUN mkdir /etc/udev/ \
    && mkdir /etc/udev/rules.d/ \
    && echo 'SUBSYSTEM=="vchiq",GROUP="video",MODE="0660"' > /etc/udev/rules.d/10-vchiq-permissions.rules

# Install requirements for add-on
RUN apk add --no-cache jq zabbix-agent raspberrypi raspberrypi-libs usbutils shadow && usermod -a -G video zabbix

##
# Set symlinks for raspberry pi binaries.
RUN ln -sv /opt/vc/bin/raspistill /usr/local/bin/raspistill \
    && ln -sv /opt/vc/bin/raspivid /usr/local/bin/raspivid \
    && ln -sv /opt/vc/bin/raspividyuv /usr/local/bin/raspividyuv \
    && ln -sv /opt/vc/bin/raspiyuv /usr/local/bin/raspiyuv

ENV LD_LIBRARY_PATH=/opt/vc/lib:${LD_LIBRARY_PATH}

RUN chmod 660 /dev/vchiq
RUN chown root:video /dev/vchiq

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]

