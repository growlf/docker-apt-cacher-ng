FROM ubuntu

VOLUME ["/var/cache/apt-cacher-ng"]

RUN apt-get update && \
    apt-get install -y \
       apt-cacher-ng \
       nano \
       ssh \
       telnet \
       nmap \
       net-tools \
       htop \
       whois \
       sudo && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN mkdir -p /var/cache/apt-cacher-ng

EXPOSE 3142

CMD chmod 777 /var/cache/apt-cacher-ng && /etc/init.d/apt-cacher-ng start && tail -f /var/log/apt-cacher-ng/*
