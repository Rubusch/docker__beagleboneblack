FROM ubuntu:20.04
MAINTAINER Lothar Rubusch <lotophagon@protonmail.com>
WORKDIR /root
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to use --build-arg USER=$USER
ARG USER=""

### the branch
ARG BRANCH="2020.11.x"



################################################################################
## set up apt fully functional
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y --purge
RUN apt-get install -y  \
        apt-utils

RUN apt-get install -y  \
        build-essential \
        libncurses5-dev \
        zlib1g-dev \
        gawk \
        wget \
        git-core \
        make \
        gcc \
        g++ \
        bison \
        flex \
        binutils \
        unzip \
        python \
        bzip2 \
        libssl-dev \
        locales \
        bc \
        cpio \
        rsync

## (opt) tools for debugging and working, e.g. X11-apps for testing the xserver via xclock
RUN apt-get install -y   \
        cvs \
        mercurial \
        subversion \
        vim \
        screen \
        minicom \
        x11-apps \
        sudo


################################################################################
## locale settings
RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8


################################################################################
## setup user and run stuff under user
RUN useradd "$USER" -m --password "$USER"
RUN usermod -a -G sudo "$USER"
RUN sed -i '/%sudo/s/.*/%sudo   ALL=NOPASSWD: ALL/' /etc/sudoers


################################################################################
### ALPINE LINUX APPROACH (not working: '_STAT_VER' undeclared)

#FROM alpine:edge
#MAINTAINER Lothar Rubusch <lotophagon@protonmail.com>
#WORKDIR /root
#
#
#################################################################################
### the USER is needed to make it available as --build-arg
### in case docker complains for a not set USER, perhaps you forgot to use --build-arg USER=$USER
#ARG USER=""
#
#ARG BRANCH="2020.11.x"
#
#
##################################################################################
#### set up apt fully functional
#RUN apk update && apk upgrade
#
### find package names and repositories for alpine linux:
### https://pkgs.alpinelinux.org/packages
#RUN apk add --update-cache \
#        --repository https://alpine.global.ssl.fastly.net/alpine/edge/community \
#        --repository https://alpine.global.ssl.fastly.net/alpine/edge/main \
#        --repository https://dl-3.alpinelinux.org/alpine/edge/testing \
#    alpine-sdk \
#    coreutils \
#    chrpath \
#    diffstat \
#    gawk \
#    ncurses-dev \
#    texinfo \
#    zlib \
#    zlib-dev \
#    libstdc++ \
#    bison \
#    flex \
#    binutils \
#    unzip \
#    python3 \
#    bzip2 \
#    libressl-dev \
#    sdl-dev \
#    xterm \
#    bc \
#    cpio \
#    rsync \
#    wget \
#    git \
#    debconf \
#    rpcgen \
#    diffutils \
#    sed \
#    findutils \
#    perl \
#    linux-headers \
#    m4 \
#    mercurial \
#    cvs \
#    subversion \
#    zig \
#    libc-dev \
#    bash
#
#### (opt) tools for debugging and working, e.g. X11-apps for testing the xserver via xclock
#RUN apk add \
#    gettext \
#    which \
#    vim \
#    screen \
#    sudo \
#    xclock
#
#
#################################################################################
### setup user and run stuff under user
#RUN adduser -D $USER \
#        && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
#        && chmod 0440 /etc/sudoers.d/$USER
#
#RUN sed -i 's/\/bin\/ash$/\/bin\/bash/' /etc/passwd
#
#
#################################################################################
### dirty hacks...
#
#RUN rm -f /bin/sh && ln -s /bin/bash /bin/sh


################################################################################
## get sources
USER $USER

## get (my) sources
## NB: the official buildroot is not able to build cross-mounted devices (thus using my patched buildroot tree)
RUN cd /home/$USER && git clone -j4 --depth=1 --branch lothar/${BRANCH} https://github.com/Rubusch/buildroot.git buildroot
## oficial buildroot (won't work due to Kbuild's use of "rename()" for moving files which is not able to move cross-device (mounted folder)
#RUN cd /home/$USER && git clone -j4 --depth=1 --branch ${BRANCH} https://github.com/buildroot/buildroot.git buildroot


################################################################################
## command mode
USER root

COPY build.sh /usr/local/bin/build.sh
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
