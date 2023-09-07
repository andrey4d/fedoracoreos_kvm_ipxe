#!/bin/bash

VM_IP="${1}"

USER="core"
CONNECTION="${USER}@${VM_IP}"

SSH="ssh ${CONNECTION}"
SCP="scp"

change_repo() {
  ${SSH} sudo mv /etc/yum.repos.d /etc/yum.repos.d.orig
  ${SCP} -r yum.repos.d ${CONNECTION}:/home/${USER}/
  ${SSH} sudo mv /home/${USER}/yum.repos.d /etc/yum.repos.d
  ${SSH} ls -al /etc/yum.repos.d
}


if [[ -n ${VM_IP} ]]; then
    change_repo
  else
    echo "Usage: ${0} <ip>"
fi


