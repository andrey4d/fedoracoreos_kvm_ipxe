
#https://dev.to/carminezacc/creating-a-kubernetes-cluster-with-fedora-coreos-36-j17

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF


master:
sudo rpm-ostree install kubelet kubeadm kubectl cri-o

nodes:
sudo rpm-ostree install kubelet kubeadm cri-o


all:
sudo systemctl enable --now crio kubelet

vi clusterconfig.yaml

kubeadm init ––config clusterconfig.yml

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f \
https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/daemonset/kubeadm-kuberouter.yaml