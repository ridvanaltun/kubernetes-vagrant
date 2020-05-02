#!/bin/bash

# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install -y apt-transport-https curl

# Add Kubernetes apt repository.
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# Install kubelet, kubeadm and kubectl.
sudo apt-get update
sudo apt-get install -y kubelet=1.18.2-00 kubeadm=1.18.2-00 kubectl=1.18.2-00

# Turn off swap for kubeadm.
sudo swapoff -a

# Hold the Kubernetes components at this specific version.
sudo apt-mark hold kubelet kubeadm kubectl