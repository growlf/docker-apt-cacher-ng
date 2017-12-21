[![GitHub issue state](https://img.shields.io/github/issues/detail/s/badges/shields/979.svg?style=plastic)](https://github.com/growlf/docker-apt-cacher-ng)

# docker-apt-cacher-ng

A docker implementation of [apt-cacher-ng](https://www.unix-ag.uni-kl.de/~bloch/acng/).

"A caching proxy. Specialized for package files from Linux distributors, primarily for Debian (and Debian based) distributions but not limited to those. See documentation of Apt-Cacher to learn what it's good for."

## USAGE

### Using the compose method

Either clone the project or simply copy the ```docker-compose.yml``` file to your target system and execute the compose command like so:

```docker-compose up```

Browse to to the local system's IP on port 3142.   

## NOTES

The page will report the containers address as the suggested proxy target - DO NOT USE THIS.  Instead, use the host system's IP.
