#!/bin/bash -e
export BUILDDIR=~/poky/build
chown $(whoami):$(whoami) -R $BUILDDIR

## adjust config files
sed "s/  ~\/poky\/meta/  \/home\/$(whoami)\/poky\/meta/g" -i /home/$USER/poky/build/meta-lothars-configs/conf/bblayers.conf.sample
cp -arf /home/$(whoami)/poky/build/meta-lothars-configs/conf/bblayers.conf.sample ${BUILDDIR}/conf/bblayers.conf
cp -arf /home/$(whoami)/poky/build/meta-lothars-configs/conf/local.conf.sample ${BUILDDIR}/conf/local.conf

## source again, before start building
cd ~/poky
source oe-init-build-env $BUILDDIR

## build
bitbake core-image-minimal
