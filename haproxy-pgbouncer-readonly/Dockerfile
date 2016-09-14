FROM haproxy:1.6.9-alpine

COPY docker-helpers/install_consul_template.sh \
    docker-helpers/install_runit.sh \
    /usr/local/bin/

RUN install_consul_template.sh && \
    rm -f \
        /usr/local/bin/install_consul_template.sh \
        /usr/local/bin/install_runit.sh

COPY consul-template.conf /etc/
COPY haproxy.cfg.ctmpl /usr/local/etc/haproxy/

COPY haproxy.service /etc/sv/haproxy/run
RUN chmod 755 /etc/sv/haproxy/run && \
    ln -s /etc/sv/haproxy /etc/service/

ENTRYPOINT ["/usr/local/bin/runsvinit"]
