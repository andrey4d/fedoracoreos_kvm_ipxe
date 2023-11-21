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
