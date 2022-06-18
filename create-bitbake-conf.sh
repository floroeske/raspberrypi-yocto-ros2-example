#!/bin/bash

set -e

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

DL_DIR="${HOME}/cache/dl"
SSTATE_DIR="${HOME}/cache/sstate"

if ! command -v bitbake &> /dev/null
then
    echo "command 'bitbake' could not be found"
    echo
    echo \"cd ${SCRIPT_DIR}/poky/\"
    echo \"source oe-init-build-env\"
    echo \"cd ${SCRIPT_DIR}\"
    exit
fi

echo "Adding bitbake layers"

pushd ./poky/build &> /dev/null
bitbake-layers add-layer \
    ${SCRIPT_DIR}/meta-openembedded/meta-oe/ \
    ${SCRIPT_DIR}/meta-openembedded/meta-multimedia/ \
    ${SCRIPT_DIR}/meta-openembedded/meta-networking \
    ${SCRIPT_DIR}/meta-openembedded/meta-python \
    ${SCRIPT_DIR}/meta-raspberrypi \
    ${SCRIPT_DIR}/meta-ros/meta-ros-common \
    ${SCRIPT_DIR}/meta-ros/meta-ros2 \
    ${SCRIPT_DIR}/meta-ros/meta-ros2-galactic \
    ${SCRIPT_DIR}/meta-ros2-demo
popd &> /dev/null

echo
echo "Modifying: '${SCRIPT_DIR}/poky/build/conf/local.conf'"
LOCAL_CONF_STRING="# ADDED BY '${SCRIPT_DIR}/create-bitbake-conf.sh'"
if grep -q "${LOCAL_CONF_STRING}" "${SCRIPT_DIR}/poky/build/conf/local.conf";
then
    :
else
    cat <<EOF >>${SCRIPT_DIR}/poky/build/conf/local.conf

${LOCAL_CONF_STRING}
DL_DIR = "${DL_DIR}"
SSTATE_DIR = "${SSTATE_DIR}"
MACHINE = "raspberrypi3-64"
BB_NUMBER_THREADS = "4"
PARALLEL_MAKE = "-j4"
IMAGE_INSTALL:append = " ros-core"
IMAGE_INSTALL:append = " demo-nodes-cpp"
IMAGE_INSTALL:append = " helloworld-service"
IMAGE_INSTALL:append = " hello"
EOF

fi

echo
echo "Please check '${SCRIPT_DIR}/poky/build/conf/local.conf'"
echo
echo "DL_DIR has been set to: '${DL_DIR}'"
echo "SSTATE_DIR has been set to: '${SSTATE_DIR}'"
echo
echo
echo "It should be possible to create a build with:"
echo "bitbake core-image-minimal"
