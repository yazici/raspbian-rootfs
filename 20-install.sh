#!/bin/bash

source cfg

if [ "$ROOTFS" == "" ]; then
    echo "No directory to install to given."
    exit 1
fi

if [ $EUID -ne 0 ]; then
    echo "This tool must be run as root."
    exec sudo /bin/bash "$0" "$@"
    # exit 1
fi

chroot $ROOTFS $QEMU_PATH /bin/sh -c '\
    apt-get update \
    && apt-get install -y libmpdclient-dev libssl-dev libpthread-stubs0-dev libc6-dev g++ make cmake \
    && symlinks -cors /'
