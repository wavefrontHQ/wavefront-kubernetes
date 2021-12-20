# Telegraf agent configured for Wavefront output intended to be used as it's own deployment to collect metrics

FROM telegraf:1.20.1-alpine

ENV WAVEFRONT_PROXY=wavefront-proxy
ENV WAVEFRONT_PROXY_PORT=2878
ENV PREFIX=
ENV SIMPLE_FIELDS=false
ENV METRIC_SEPARATOR=.
ENV CONVERT_PATHS=true
ENV USE_REGEX=false
ENV SOURCE_OVERRIDE=address
ENV CONVERT_BOOL=true

ENV INTERVAL=60s

COPY telegraf.conf /etc/telegraf/telegraf.conf

CMD ["telegraf", "--config", "/etc/telegraf/telegraf.conf", "--config-directory", "/etc/telegraf/telegraf.d"]
