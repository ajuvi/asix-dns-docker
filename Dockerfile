FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    bind9 \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/bind/

COPY named.conf.options /etc/bind/named.conf.options
COPY named.conf.local /etc/bind/named.conf.local
COPY db.asix.local /etc/bind/db.asix.local

RUN chown -R bind:bind /etc/bind

EXPOSE 53/udp
EXPOSE 53/tcp

CMD ["named", "-g"]
