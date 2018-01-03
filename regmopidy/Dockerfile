#ARG BUILD_FROM
#ARG BUILD_VERSION
#FROM ${BUILD_FROM}

#FROM bestlibre/armhf-mopidy:0.1.2

ENV LANG C.UTF-8

#Install mopidy

COPY mopidy.conf /var/lib/mopidy/.config/mopidy/mopidy.conf

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

EXPOSE 6600 6680
CMD [ "/run.sh" ]
