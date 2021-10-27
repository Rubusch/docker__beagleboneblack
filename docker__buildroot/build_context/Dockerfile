################################################################################
## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to
## use --build-arg USER=$USER
ARG USER="${USER}"
ARG UID="${UID}"
ARG GID="${GID}"

ARG DOCKER_BASE="sandbox"
ARG DOCKER_BASE_TAG="20211027"


################################################################################
FROM ${USER}/${DOCKER_BASE}:${DOCKER_BASE_TAG} AS bbb_buildroot
MAINTAINER Lothar Rubusch <l.rubusch@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive


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
## command mode
USER ${USER}
WORKDIR /home/$USER
COPY *.sh /usr/local/bin/
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
