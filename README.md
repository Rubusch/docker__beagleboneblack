[![CircleCI](https://circleci.com/gh/Rubusch/docker__beagleboneblack.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__beagleboneblack)
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)


# Docker Container for my BeagleBoneBlack (bbb)


## Resources

https://beagleboard.org/p/30847/yocto-on-beaglebone-black-9ae649


## Yocto

### Build


```
$ cd ./docker__yocto/
$ time docker build --no-cache --build-arg USER=$USER -t rubuschl/bbb-yocto:$(date +%Y%m%d%H%M%S) .
```


### Usage

```
$ docker images
    REPOSITORY         TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/bbb-yocto 20191104161353      cbf4cb380168        24 minutes ago      10.5GB
    ...

$ docker run -ti -v $PWD/output:/home/$USER/poky/build -v $PWD/meta-lothars-configs:/home/$USER/poky/meta-lothars-configs --user=$USER:$USER --workdir=/home/$USER rubuschl/bbb-yocto:20191104161353 /bin/bash

docker $> build.sh
```


## Buildroot

### Build

```
$ cd ./docker__buildroot
$ time docker build --no-cache --build-arg USER=$USER -t rubuschl/bbb-buildroot:$(date +%Y%m%d%H%M%S) .
```


### Usage

```
$ docker images
    REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/bbb-buildroot 20191104161353      cbf4cb380168        24 minutes ago      10.5GB
    ...

$ docker run -ti -v $PWD/output:/home/$USER/poky/build -v $PWD/meta-lothars-configs:/home/$USER/poky/meta-lothars-configs --user=$USER:$USER --workdir=/home/$USER rubuschl/bbb-buildroot:20191104161353 /bin/bash

docker $> build.sh
```

