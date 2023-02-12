### kubectl -n kube-system get configmap kubeadm-config -o jsonpath='{.data.ClusterConfiguration}' > kubeadm.yaml
```shell
vi kubeadm.yaml
```

```yaml
---
apiServer:
  certSANs:
  - "172.29.50.162"
  - "k8s.domain.com"
  - "other-k8s.domain.net"
  extraArgs:
    authorization-mode: Node,RBAC
    timeoutForControlPlane: 4m0s
```

kubeadm init phase certs apiserver --config kubeadm.yaml

crictl stop kube-apiserve