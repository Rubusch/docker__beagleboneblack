[![CircleCI](https://circleci.com/gh/Rubusch/docker__beagleboneblack.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__beagleboneblack)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)


# Docker Container for my BeagleBoneBlack (bbb)


## References

https://beagleboard.org/p/30847/yocto-on-beaglebone-black-9ae649


## Tools Needed

```
$ sudo apt-get install -y libffi-dev libssl-dev
$ sudo apt-get install -y python3-dev
$ sudo apt-get install -y python3 python3-pip
$ pip3 install docker-compose
```

Make sure, ``~/.local`` is within ``$PATH`` or re-link e.g. it to ``/usr/local``.  


## Buildroot

### Build

```
$ DOCKERDIR=docker__buildroot ./setup.sh
```

### Usage

```
$ cd docker__buildroot
$ docker-compose -f ./docker-compose.yml run --rm bbb_buildroot /bin/bash
docker $> build.sh
```


## Yocto

### Build

```
$ DOCKERDIR=docker__yocto ./setup.sh
```


### Usage

In case of a re-build, make sure to clean sufficiently before

```
$ cd ./docker__yocto
$ docker-compose -f ./docker-compose.yml run --rm bbb_yocto /bin/bash
```

**yocto SDK** - Inside the **same** session, you can compile as follows.
