FROM ubuntu

MAINTAINER thenetyeti@thenetyeti.com

# Set the working directory
VOLUME ["/var/cache/apt-cacher-ng"]

# Update and install the basics - keep it cleaned
RUN apt-get update && \
    apt-get install -y \
       apt-cacher-ng && \
    apt-get clean && \
    rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# Generate the cach directory
RUN mkdir -p /var/cache/apt-cacher-ng

# Copy the config over - warning, this config allows full proxying and the service should be public facing with this config
COPY ./acng.conf /etc/apt-cacher-ng/

# Make sure the port is open for proxying
EXPOSE 3142

# Run the service manually so that we can watch the log output from docker commands
CMD chmod 777 /var/cache/apt-cacher-ng && /etc/init.d/apt-cacher-ng start && tail -f /var/log/apt-cacher-ng/*
