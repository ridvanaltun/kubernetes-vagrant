#!/bin/bash

# Install kubernetes via kubeadm.
kubeadm init --apiserver-advertise-address=10.0.0.10 --pod-network-cidr=10.244.0.0/16

# Export k8s cluster token to an external file.
OUTPUT_FILE=/vagrant/join.sh
rm -rf /vagrant/join.sh
kubeadm token create --print-join-command > /vagrant/join.sh
chmod +x $OUTPUT_FILE

# Prepare kubectl.
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# Apply flannel.
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml