# docker-apt-cacher-ng

"A caching proxy. Specialized for package files from Linux distributors, primarily for Debian (and Debian based) distributions but not limited to those. See documentation of Apt-Cacher to learn what it's good for."

A docker implementation of [apt-cacher-ng](https://www.unix-ag.uni-kl.de/~bloch/acng/).  This image contains support for CentOS as well as the usual suspects, and is intended to be used within a LAN and not on a public facing IP.


## INSTALLATION

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

## USAGE

### Ubuntu

Create `/etc/apt/apt.conf.d/01proxy` with a single line specifying the cacher as the proxy like so:`Acquire::http::Proxy "http://<host_ip_address>:3142";`

### CentOS

Add a line to `/etc/yum.conf` like so: `proxy=http://<host_ip_address>:3142`

### Rasbian and Armbian

I found that I needed to follow the advice from [TSpark](https://askubuntu.com/questions/1263284/apt-update-throws-signature-error-in-ubuntu-20-04-container-on-arm) on my Odroid, RaspBerry Pi 4 and similar ARM based evices.  This requirement may change (and hopefully disapear) - but for now (and until the repos catch up) this did solve the build/run issues related to the followin errors:

    W: GPG error: http://ports.ubuntu.com/ubuntu-ports focal InRelease: At least one invalid signature was encountered.
    E: The repository 'http://ports.ubuntu.com/ubuntu-ports focal InRelease' is not signed.

For me it was a simple thing - on the host ARM device download the package and install it like so:

    cd /tmp
    wget http://http.us.debian.org/debian/pool/main/libs/libseccomp/libseccomp2_2.5.1-1_armhf.deb
    sudo dpkg -i libseccomp2_2.5.1-1_armhf.deb

After that, I was able to build (and run) the image with no issues.

## NOTES

The information page will report the containers address as the suggested proxy target - DO NOT USE THIS.  Instead, use the host system's IP.

The defaut `acng.conf` that is included allows full proxying to simplify support for SSL/TLS repositories. This may be a security issue if access is allowed to the service from the open internet.  Please consider either changing the configuration or denying access via public interface.

Agood source (that was not around when I built this originally) is direct from the [Docker docs](https://docs.docker.com/samples/apt-cacher-ng/)

