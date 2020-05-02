# Kubernetes Vagrant

Manage kubernetes cluster with vagrant.

# Overview

- *Docker Version:* 19.03.8-3-0
- *Kubectl Version:* 1.18.2-00
- *Kubeadm Version:* 1.18.2-00

# Example Usage

```bash
# up one master and two worker node
$ vagrant up m n1 n2

# connect master node
$ vagrant ssh m

# disable swap
$ sudo swapoff -a

# install cluster
$ sudo kubeadm init --apiserver-advertise-address=177.27.44.200

# configure kubectl in master node
$ mkdir -p $HOME/.kube
$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

# connect worker-node-1
$ vagrant ssh n1

# connect worker-node-1 to master node
$ kubeadm join 172.27.44.200:6443 --token h80ccu.axlbt8cwcvizi58m  --discovery-token-ca-cert-hash sha256:4a67fbbca187a09f4a881325acbc2fbf0a9236b52eb3408832cbd37a3752a3a3
```
