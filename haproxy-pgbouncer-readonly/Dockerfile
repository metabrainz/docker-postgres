FROM metabrainz/consul-template-base

RUN apk add --no-cache haproxy

COPY consul-template.conf /etc/
COPY haproxy.cfg.ctmpl /usr/local/etc/haproxy/

COPY haproxy.service /etc/sv/haproxy/run
RUN chmod 755 /etc/sv/haproxy/run && \
    ln -s /etc/sv/haproxy /etc/service/

ENTRYPOINT ["/usr/local/bin/runsvinit"]

EXPOSE 6899
