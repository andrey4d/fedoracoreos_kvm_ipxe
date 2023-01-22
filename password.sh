#!/bin/bash

DOCKER="podman"

${DOCKER} run -ti --rm quay.io/coreos/mkpasswd --method=yescrypt
