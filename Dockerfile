FROM ubuntu:22.04

# Instala BIND y utilidades necesarias
RUN apt-get update && apt-get install -y \
    bind9 \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*

# Crea los directorios necesarios para BIND
RUN mkdir -p /etc/bind/zones

# Copia la configuración principal de BIND
COPY named.conf /etc/bind/named.conf

# Copia los archivos de zona personalizados
COPY zones/db.asix.local /etc/bind/zones/db.asix.local

# Establece permisos adecuados para los archivos
RUN chown -R bind:bind /etc/bind

# Exponer el puerto DNS (53)
EXPOSE 53/udp
EXPOSE 53/tcp

# Comando para iniciar BIND en modo foreground
CMD ["named", "-g"]
