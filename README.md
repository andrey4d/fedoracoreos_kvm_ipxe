# fedoracoreos_kvm_ipxe
### Create VM Fedora CoreOS use ipxe boot
## Create VM
```shell
./01_create-vm-master.sh
```

### Edit fcos-config.yml
```yaml
variant: fcos
version: 1.4.0
passwd:
  users:
    - name: core
#     default password = password (make hash ./password.sh)
      password_hash: "$y$j9T$IhkUF7pj2rOJGzcvj7xad/$LK5p3T298qXuDasicX5pv7an9agjQcBHLMIPXJgxhW0"
      ssh_authorized_keys:
#       public key cat ~/.ssh/id_rsa.pub
        - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC...........
```

### Virsh
```shell
virsh connect qemu+libssh2://user@host/system
virt-manager -c 'qemu+ssh://user@libvirthost/system?socket=/var/run/libvirt/libvirt-sock'
virt-viewer -c 'qemu+ssh://user@libvirthost/system?socket=/var/run/libvirt/libvirt-sock'
```

```shell
sudo nmcli connection modify Wired\ connection\ 1 ipv4.dns 8.8.8.8
```

### Network
bridge 
nmcli + dhcp
```shell
#!/bin/sh -e


INTERFACE=ens3

sudo nmcli con add type bridge ifname br0
sudo nmcli con mod bridge-br0 bridge.stp no
sudo nmcli con add type bridge-slave ifname ${INTERFACE} master bridge-br0
sudo reboot
```
nmcli + Static IP Address 
```shell
#!/bin/sh -e


INTERFACE=ens3

sudo nmcli con add type bridge ifname br0
sudo nmcli con mod bridge-br0 bridge.stp no
sudo nmcli con add type bridge-slave ifname ${INTERFACE} master bridge-br0
sudo nmcli con modify bridge-br0 ipv4.method manual \
         ipv4.address "192.168.11.250/24" \
         ipv4.gateway "192.168.11.1" \
         ipv4.dns "192.168.11.2" \
         ipv4.dns-search "hiroom2.com"
sudo reboot
```
