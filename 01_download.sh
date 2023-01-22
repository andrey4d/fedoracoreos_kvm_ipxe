#!/bin/bash

VERSION="37.20221225.3.0"
mkdir coreos
podman run --security-opt label=disable --pull=always --rm -v $PWD/coreos:/data -w /data quay.io/coreos/coreos-installer:release download -f pxe
