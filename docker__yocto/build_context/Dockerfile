################################################################################
## ATTENTION: multistage build
##
## based on current USER and TAG, DOCKER_BASE:
## https://github.com/Rubusch/docker__zephyr-base
##
################################################################################
## base image settings
ARG USER="${USER}"
ARG DOCKER_BASE="sandbox"
ARG DOCKER_BASE_TAG="20221228"


################################################################################
## base image
FROM ${USER}/${DOCKER_BASE}:${DOCKER_BASE_TAG} AS bbb_yocto
MAINTAINER Lothar Rubusch <l.rubusch@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## environment (applied ARG/ENV must come after FROM declaration)
ARG USER="${USER}"


################################################################################
## sources
USER $USER
WORKDIR /home/$USER
RUN mkdir -p /home/$USER/poky


################################################################################
## command mode
USER ${USER}
WORKDIR /home/$USER
COPY *.sh /usr/local/bin/
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
