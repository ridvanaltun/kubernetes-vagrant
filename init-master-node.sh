#!/bin/bash

# Install kubernetes via kubeadm.
kubeadm init --apiserver-advertise-address=10.0.0.10 --pod-network-cidr=10.244.0.0/16

# Export k8s cluster token to an external file.
OUTPUT_FILE=/vagrant/join.sh
rm -rf /vagrant/join.sh
kubeadm token create --print-join-command > /vagrant/join.sh
chmod +x $OUTPUT_FILE