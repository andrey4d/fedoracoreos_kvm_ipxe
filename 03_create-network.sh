#!/bin/bash

SUDO="sudo"

${SUDO} virsh net-define coreosnetwork.xml
${SUDO} virsh net-start coreosnetwork
${SUDO} virsh net-autostart coreosnetwork
