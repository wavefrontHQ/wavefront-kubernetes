# Telegraf agent configured for Wavefront output intended to be used in a sidecar config

FROM telegraf:1.7.1

ENV WAVEFRONT_PROXY=wavefront-proxy
ENV WAVEFRONT_PROXY_PORT=2878
ENV INTERVAL=60s

COPY telegraf.conf /etc/telegraf/telegraf.conf

CMD ["telegraf", "--config", "/etc/telegraf/telegraf.conf", "--config-directory", "/etc/telegraf/telegraf.d"]
