FROM ubuntu:22.04

# Instalar bind9 y dnsutils, limpiando caché para optimizar el tamaño de la imagen
RUN apt-get update && apt-get install -y \
    bind9 \
    dnsutils \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Crear directorio para la configuración de BIND
RUN mkdir -p /etc/bind/

# Copiar archivos de configuración al contenedor
COPY named.conf.options /etc/bind/named.conf.options
COPY named.conf.local /etc/bind/named.conf.local
COPY db.asix.local /etc/bind/db.asix.local

# Asegurarse de que el propietario de los archivos sea el usuario 'bind'
RUN useradd -r -m bind && chown -R bind:bind /etc/bind

# Exponer los puertos 53 para UDP y TCP
EXPOSE 53/udp
EXPOSE 53/tcp

# Iniciar BIND cuando el contenedor se ejecute
CMD ["named", "-g"]