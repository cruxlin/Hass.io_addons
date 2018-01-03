ARG BUILD_FROM
ARG BUILD_VERSION
FROM ${BUILD_FROM}-${BUILD_VERSION}

# Copy data
COPY run.sh /
COPY mosquitto.conf /etc/mosquitto/
COPY snips.toml /etc/
COPY asound.conf /etc/
COPY alsa.conf /usr/share/alsa/
COPY snips-entrypoint.sh /opt/snips/snips-entrypoint.sh
RUN chmod a+x /opt/snips/snips-entrypoint.sh
RUN chmod a+x /run.sh

ENTRYPOINT [ "/run.sh" ]

