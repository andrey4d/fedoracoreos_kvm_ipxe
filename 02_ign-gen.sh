#!/bin/bash

DOCKER="podman"
#IMAGE="quay.io/coreos/butane:release"
IMAGE="quay.io/coreos/fcct:latest"

cp fcos-config-sample.yml fcos-config.yml
echo "        - $(cat ~/.ssh/id_rsa.pub)" >> fcos-config.yml

${DOCKER} run -i --rm ${IMAGE} -p -s <fcos-config.yml | tee coreos/fcos-config.ign

