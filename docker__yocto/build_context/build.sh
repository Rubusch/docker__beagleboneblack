#!/bin/bash -e

MY_USER="$(whoami)"
MY_HOME="/home/${MY_USER}"
SSH_DIR="${MY_HOME}/.ssh"
SSH_KNOWN_HOSTS="${SSH_DIR}/known_hosts"
YOCTO_BRANCH="dunfell"
YOCTO_DIR="${MY_HOME}/poky"
BUILD_DIR="${YOCTO_DIR}/build"

## permissions
for item in "${YOCTO_DIR}" "${SSH_DIR}" "${MY_HOME}/meta-lothars-configs"; do
    if [ ! "${MY_USER}" == "$( stat -c %U ${item} )" ]; then
        ## may take some time
        sudo chown "${MY_USER}:${MY_USER}" -R ${item}
    fi
done

## ssh known_hosts
touch ${SSH_KNOWN_HOSTS}
for item in "github.com" "bitbucket.org"; do
    if [ "" == "$( grep ${item} -r ${SSH_KNOWN_HOSTS} )" ]; then
        ssh-keyscan "${item}" >> "${SSH_KNOWN_HOSTS}"
    fi
done

## initial clone
FIRST="$(ls -A "${YOCTO_DIR}")"
if [ -z "${FIRST}" ]; then
    cd "${MY_HOME}"
    git clone -b "${YOCTO_BRANCH}" git://git.yoctoproject.org/poky "${YOCTO_DIR}"

    cd "${YOCTO_DIR}"
    git clone -b "${YOCTO_BRANCH}" git://git.openembedded.org/meta-openembedded
    git clone -b "${YOCTO_BRANCH}" https://github.com/meta-qt5/meta-qt5.git

    git clone git://github.com/beagleboard/meta-beagleboard.git bbb
fi

## source again, before start building
cd "${YOCTO_DIR}"
source oe-init-build-env "${BUILD_DIR}"

## layers.conf and bblayers.conf (edit those two!)
cp -arf "${MY_HOME}"/meta-lothars-configs/conf/bblayers.conf.sample "${BUILD_DIR}"/conf/bblayers.conf

cp -arf "${MY_HOME}"/meta-lothars-configs/conf/local.conf.sample "${BUILD_DIR}"/conf/local.conf

## adjust config files
sed "s/  ~\/poky\/meta/  \/home\/$(whoami)\/poky\/meta/g" -i "${BUILD_DIR}"/conf/bblayers.conf

## build
bitbake core-image-minimal $@

echo "READY."
echo
