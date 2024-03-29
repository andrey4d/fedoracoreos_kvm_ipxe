#!/bin/bash

DOCKER="docker"
#IMAGE_BUTANE="quay.io/coreos/butane:release"
IMAGE_BUTANE="quay.io/coreos/fcct:latest"

VERSION="38.20231027.3.1"
IMAGE_DOWNLOAD="quay.io/coreos/coreos-installer:release"

CONNECTION="qemu:///session?socket=/Users/andrey/.cache/libvirt/libvirt-sock"


${DOCKER} run --security-opt label=disable --pull=always --rm -v "${PWD}/coreos:/data" -w /data ${IMAGE_DOWNLOAD} download -f pxe


if [[ ! -f ./fcos-config.yml ]]; then
  cp fcos-config-sample.yml fcos-config.yml
  echo "        - $(cat ~/.ssh/id_rsa.pub)" >> fcos-config.yml
fi

${DOCKER} run -i --rm ${IMAGE_BUTANE} -p -s <fcos-config.yml | tee coreos/fcos-config.ign


if [[ $("${SUDO}" virsh --connect="${CONNECTION}" net-list --all | grep -c "${NETWORK}") == "0" ]]; then
  ${SUDO} virsh --connect="${CONNECTION}" net-define "${NETWORK}.xml"
  ${SUDO} virsh --connect="${CONNECTION}" net-start "${NETWORK}"
  ${SUDO} virsh --connect="${CONNECTION}" net-autostart "${NETWORK}"
fi

${SUDO} ${DOCKER} run -d --rm --name http-server -p 192.168.123.1:80:8080  -v "${PWD}/coreos:/coreos:z" -w /coreos docker.io/python:alpine3.17 python -m http.server 8080

${SUDO}  virt-install --connect="${CONNECTION}" \
  --name="${VM_NAME}" \
  --vcpus="${VCPUS}" \
  --memory="${RAM_MB}" \
  --os-variant="fedora-coreos-$STREAM" \
  --pxe --network network="${NETWORK}" \
  --graphics=spice \
  --channel=spicevmc \
  --disk="size=${DISK_GB}" \
  --serial pty \
  --console pty,target_type=virtio \
  --boot menu=on,useserial=on


${SUDO} ${DOCKER} kill http-server
