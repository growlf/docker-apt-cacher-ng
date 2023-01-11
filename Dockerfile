# Dockerized apt-cacher-ng (caching proxy) to speed installation of linux packages

FROM ubuntu:trusty
MAINTAINER netyeti@thenetyeti.com

# Install apt-cacher-ng and cleanup afterwards
ARG APT_CACHER_NG
RUN [ -n "$APT_CACHER_NG" ] && \
      echo "Acquire::http::Proxy \"$APT_CACHER_NG\";" \
      > /etc/apt/apt.conf.d/11proxy || true; \
    apt-get update && \
    apt-get install -y apt-cacher-ng && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /etc/apt/apt.conf.d/11proxy

# Configure apt-cacher-ng to make sure it won't proxy https and 
# link stdout and stderr to apt-cacher-ng log files (happier docker logging)
RUN echo "PassThroughPattern: .*:443$" >> /etc/apt-cacher-ng/acng.conf && \
    ln -sf /dev/stdout /var/log/apt-cacher-ng/apt-cacher.log && \
    ln -sf /dev/stderr /var/log/apt-cacher-ng/apt-cacher.err

# Allow easy mounting of persistant volumes for log and cache files
VOLUME ["/var/log", "/var/cache/apt-cacher-ng"]

# Export the standard port that apt-cacher-ng serves up
EXPOSE 3142

# Run the proxy in forground mode for better docker logging experience
CMD ["/usr/sbin/apt-cacher-ng", "-c", "/etc/apt-cacher-ng/", "ForeGround=1"]
