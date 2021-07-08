#!/bin/bash -e

export MY_USER="$(whoami)"
export MY_HOME="/home/${MY_USER}"
export SSH_DIR="${MY_HOME}/.ssh"
export SSH_KNOWN_HOSTS="${SSH_DIR}/known_hosts"
export YOCTO_BRANCH="dunfell"
export YOCTO_DIR="${MY_HOME}/poky"
export BUILD_DIR="${YOCTO_DIR}/build"

## permissions
for item in "${YOCTO_DIR}" "${SSH_DIR}" "${MY_HOME}/meta-lothars-configs" "${MY_HOME}/.gitconfig"; do
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
if [[ "1" == "$(find ${YOCTO_DIR} | wc -l)" ]]; then
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
