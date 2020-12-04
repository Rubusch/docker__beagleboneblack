FROM alpine:edge
MAINTAINER Lothar Rubusch <lotophagon@protonmail.com>
WORKDIR /root


################################################################################
## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to use --build-arg USER=$USER
ARG USER=""

## the yocto branch
ARG BRANCH_BUILDROOT="2020.05.x"


#################################################################################
### set up apt fully functional
RUN apk update && apk upgrade

## find package names and repositories for alpine linux:
## https://pkgs.alpinelinux.org/packages
RUN apk add --update-cache \
        --repository https://alpine.global.ssl.fastly.net/alpine/edge/community \
        --repository https://alpine.global.ssl.fastly.net/alpine/edge/main \
        --repository https://dl-3.alpinelinux.org/alpine/edge/testing \
    alpine-sdk \
	coreutils \
    chrpath \
    diffstat \
    gawk \
    ncurses-dev \
    texinfo \
    zlib-dev \
    bison \
    flex \
    binutils \
    unzip \
    python3 \
    bzip2 \
    libressl-dev \
    sdl-dev \
    xterm \
    bc \
    cpio \
    rsync \
    wget \
    git \
    debconf \
    rpcgen \
    diffutils \
    sed \
    findutils \
    perl \
    linux-headers \
    m4 \
    mercurial \
    cvs \
    subversion

### (opt) tools for debugging and working, e.g. X11-apps for testing the xserver via xclock
RUN apk add \
    bash \
    vim \
    screen \
    sudo \
    xclock


################################################################################
## setup user and run stuff under user
RUN adduser -D $USER \
        && echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER \
        && chmod 0440 /etc/sudoers.d/$USER

RUN sed -i 's/\/bin\/ash$/\/bin\/bash/' /etc/passwd


################################################################################
## dirty hacks...

RUN rm -f /bin/sh && ln -s /bin/bash /bin/sh


################################################################################
## get sources
USER $USER

## get (my) sources
#RUN cd /home/$USER && git clone -j4 --depth=1 --branch ${BRANCH_BUILDROOT} https://github.com/Rubusch/buildroot.git buildroot
RUN cd /home/$USER && git clone -j4 --depth=1 --branch ${BRANCH_BUILDROOT} https://github.com/buildroot/buildroot.git buildroot


################################################################################
## command mode
USER root

COPY build.sh /usr/local/bin/build.sh
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
