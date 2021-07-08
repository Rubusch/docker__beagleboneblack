[![CircleCI](https://circleci.com/gh/Rubusch/docker__beagleboneblack.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__beagleboneblack)
[![License: GPL v3](https://img.shields.io/badge/License-GPL%20v3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)


# Docker Container for my BeagleBoneBlack (bbb)


## References

https://beagleboard.org/p/30847/yocto-on-beaglebone-black-9ae649


## Tools Needed

```
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-comp\
ose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod a+x /usr/local/bin/docker-compose
```

NB: Where 1.28.6 is the latest version (currently not supported by devian/ubuntu package management)  


## Buildroot

(debug: experimental setup on alpine linux commented out)   


### Build

```
$ cd ./docker__buildroot
$ time docker build --build-arg USER=$USER -t rubuschl/bbb-buildroot:$(date +%Y%m%d%H%M%S) .
```


### Usage

```
$ docker images
    REPOSITORY             TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/bbb-buildroot 20191104161353      cbf4cb380168        24 minutes ago      10.5GB
    ...

$ docker run --rm -ti --user=$USER:$USER --workdir=/home/$USER -v $PWD/output:/home/$USER/buildroot/output -v $PWD/dl:/home/$USER/buildroot/dl rubuschl/bbb-buildroot:20191104161353 /bin/bash

docker $> build.sh
```



## Yocto

### Build


```
$ cd ./docker__yocto
$ docker-compose up
```


### Usage

In case of a re-build, make sure to clean sufficiently before

```
$ docker-compose -f ./docker-compose.yml run --rm bbb_yocto /bin/bash
```

**yocto SDK** - Inside the **same** session, you can compile as follows.
