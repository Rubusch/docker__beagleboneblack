#!/bin/sh -e

MY_USER="$(whoami)"
MY_HOME="/home/${MY_USER}"
SSH_DIR="${MY_HOME}/.ssh"
SSH_KNOWN_HOSTS="${SSH_DIR}/known_hosts"
BR_DIR="${MY_HOME}/buildroot"

export DEFCONFIG="beaglebone_defconfig"
export BRANCH="2020.11.x"

## permissions
for item in "${BR_DIR}" "${SSH_DIR}" "${MY_HOME}/.gitconfig"; do
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
FIRST="$(ls -A "${BR_DIR}")"
if [ -z "${FIRST}" ]; then
    cd "${BR_DIR}"
    ## get (my) sources
    ## NB: the official buildroot is not able to build cross-mounted devices (thus using my patched buildroot tree)
    #git clone -j4 --depth=1 --branch "lothar/${BRANCH}" https://github.com/Rubusch/buildroot.git .
    ## oficial buildroot (won't work due to Kbuild's use of "rename()" for moving files which is not able to move cross-device (mounted folder)
    git clone -j4 --depth=1 --branch ${BRANCH} https://github.com/buildroot/buildroot.git .
fi

cd "${BR_DIR}"
make defconfig "${DEFCONFIG}" || exit 1
make -j"$(nproc)" || exit 1

echo "READY."
echo
