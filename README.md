# Docker Container for my BeagleBoneBlack (bbb)


## Resources

https://beagleboard.org/p/30847/yocto-on-beaglebone-black-9ae649


## Build


```
$ cd ./docker__yocto/
$ time docker build --no-cache --build-arg USER=$USER -t rubuschl/bbb-yocto:$(date +%Y%m%d%H%M%S) .
```


## Usage

```
$ docker images
    REPOSITORY         TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/bbb-yocto 20191104161353      cbf4cb380168        24 minutes ago      10.5GB
    ubuntu             xenial              5f2bf26e3524        4 days ago          123MB

$ docker run -ti -v $PWD/output:/home/$USER/poky/build -v $PWD/meta-lothars-configs:/home/$USER/poky/meta-lothars-configs --user=$USER:$USER --workdir=/home/$USER rubuschl/bbb-yocto:20191104161353
```

Append ``/bin/bash`` for debugging/working in the container
