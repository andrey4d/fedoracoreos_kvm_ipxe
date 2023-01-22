# fedoracoreos_kvm_ipxe
### Create VM Fedora CoreOS use ipxe boot

## 1 Download Fedora CoreOS
```shell
./01_download.sh
```
## 2 Create ignition file
```shell
cp fcos-config-sample.yml fcos-config.yml
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
### Generate file 
```shell
02_ign-gen.sh
```
## 3 Create network
```shell
./03_create-network.sh
```

## 4 Create VM
```shell
./04_create-vm-master.sh
```
