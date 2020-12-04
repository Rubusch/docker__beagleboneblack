#!/bin/bash -e

export USER="$(whoami)"
export DEFCONFIG=beaglebone_defconfig
export MY_HOME=/home/${USER}

sudo chown ${USER}:${USER} -R ${MY_HOME}/buildroot/dl
sudo chown ${USER}:${USER} -R ${MY_HOME}/buildroot/output

cd ${MY_HOME}/buildroot
make defconfig ${DEFCONFIG}
make -j8

echo "READY."
echo
