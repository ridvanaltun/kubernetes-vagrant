#!/bin/bash

# Install packages to allow apt to use a repository over HTTPS
apt-get install -y apt-transport-https curl

# Add Kubernetes apt repository.

## Download the Google Cloud public signing key
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

## Add the Kubernetes apt repository
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

## Update apt package index with the new repository
apt-get update

# Install kubelet, kubeadm and kubectl.
apt-get install -y kubelet=1.21.2-00 kubeadm=1.21.2-00 kubectl=1.21.2-00

# Hold the Kubernetes components at this specific version.
apt-mark hold kubelet kubeadm kubectl

# Turn off swap for kubeadm.
swapoff -a
sed -i '/swap/d' /etc/fstab