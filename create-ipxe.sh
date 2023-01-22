#!/bin/bash



if [[ $("${SUDO}" virsh net-list --all | grep -c "${NETWORK}") == "0" ]]; then
  ${SUDO} virsh net-define "${NETWORK}.xml"
  ${SUDO} virsh net-start "${NETWORK}"
  ${SUDO} virsh net-autostart "${NETWORK}"
fi


sudo podman run -d --rm --name http-server -p 192.168.123.1:80:8080  -v ${PWD}/coreos:/coreos:z -w /coreos docker.io/python:alpine3.17 python -m http.server 8080

${SUDO}  virt-install --connect="qemu:///system" \
  --name="${VM_NAME}" \
  --vcpus="${VCPUS}" \
  --memory="${RAM_MB}" \
  --os-variant="fedora-coreos-$STREAM" \
  --pxe --network network=${NETWORK} \
  --graphics=spice \
  --channel=spicevmc \
  --disk="size=${DISK_GB}" \
  --serial pty \
  --console pty,target_type=virtio \
  --boot menu=on,useserial=on


sudo podman kill http-server

