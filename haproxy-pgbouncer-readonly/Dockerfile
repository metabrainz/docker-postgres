FROM metabrainz/consul-template-base

RUN apt-get update && \
    apt-get install --no-install-recommends -y haproxy && \
    rm -rf /var/lib/apt/lists/*

COPY consul-template.conf /etc/
COPY haproxy.cfg.ctmpl /usr/local/etc/haproxy/
COPY haproxy.service /etc/service/haproxy/run

RUN chmod 755 /etc/service/haproxy/run

EXPOSE 6899
