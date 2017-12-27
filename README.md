# docker-apt-cacher-ng

A docker implementation of [apt-cacher-ng](https://www.unix-ag.uni-kl.de/~bloch/acng/).

"A caching proxy. Specialized for package files from Linux distributors, primarily for Debian (and Debian based) distributions but not limited to those. See documentation of Apt-Cacher to learn what it's good for."

## USAGE

Ensure that you have already installed [docker](https://docs.docker.com/engine/installation/). Next, select the method you wish to use for running the container.

### Using the docker-compose method

This assumes that you have already installed [docker-compose](https://docs.docker.com/compose/install/). Either clone the project or simply copy the [docker-compose.yml](https://raw.githubusercontent.com/growlf/docker-apt-cacher-ng/master/docker-compose.yml) file to your host system and execute the compose command from the same folder, like so:

```sh
docker-compose pull
docker-compose up -d
```

### Using the docker command

If you do not have docker-compose installed, you can simply run the container with docker itself, like so:

```sh
docker pull yeticraft/docker-apt-cacher-ng
docker volume create aptcacher-cache
docker run -d -v aptcacher-cache:/var/cache/apt-cacher-ng -p 3142:3142 --name=aptcacher -it yeticraft/docker-apt-cacher-ng
```

Now you can test the container by browsing to the host system's IP on port 3142 (http://<host_system_ip>:3142) where you can see statistics and instructions on using the cacher.

## NOTES

The information page will report the containers address as the suggested proxy target - DO NOT USE THIS.  Instead, use the host system's IP.

## Coming soon

Support for CentOS clients.
