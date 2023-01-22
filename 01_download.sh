#!/bin/bash

VERSION="37.20221225.3.0"
DOCKER="podman"
IMAGE="quay.io/coreos/coreos-installer:release"


${DOCKER} run --security-opt label=disable --pull=always --rm -v "${PWD}/coreos:/data" -w /data ${IMAGE} download -f pxe
