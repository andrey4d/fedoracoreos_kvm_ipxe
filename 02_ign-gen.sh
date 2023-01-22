#!/bin/bash

#IMAGE="quay.io/coreos/butane:release"
IMAGE="quay.io/coreos/fcct:latest"

podman run -i --rm ${IMAGE} -p -s <fcos-config.yml > coreos/fcos-config.ign

