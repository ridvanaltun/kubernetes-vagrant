#!/bin/bash

# Install packages to allow apt to use a repository over HTTPS
apt-get install -y apt-transport-https curl

# Add Kubernetes apt repository.
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
touch /etc/apt/sources.list.d/kubernetes.list
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update

# Install kubelet, kubeadm and kubectl.
apt-get install -y kubelet=1.18.2-00 kubeadm=1.18.2-00 kubectl=1.18.2-00

# Hold the Kubernetes components at this specific version.
apt-mark hold kubelet kubeadm kubectl

# Turn off swap for kubeadm.
swapoff -a
sed -i '/swap/d' /etc/fstab