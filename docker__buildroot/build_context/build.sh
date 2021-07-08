#!/bin/bash -e

export USER="$(whoami)"
export DEFCONFIG=beaglebone_defconfig
export MY_HOME=/home/${USER}

sudo chown "${USER}:${USER}" -R "${MY_HOME}/buildroot"

## get (my) sources
## NB: the official buildroot is not able to build cross-mounted devices (thus using my patched buildroot tree)
git clone -j4 --depth=1 --branch "lothar/${BRANCH}" https://github.com/Rubusch/buildroot.git buildroot
## oficial buildroot (won't work due to Kbuild's use of "rename()" for moving files which is not able to move cross-device (mounted folder)
#RUN cd /home/$USER && git clone -j4 --depth=1 --branch ${BRANCH} https://github.com/buildroot/buildroot.git buildroot

cd "${MY_HOME}/buildroot"
make defconfig "${DEFCONFIG}"
make -j8

echo "READY."
echo
