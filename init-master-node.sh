#!/bin/bash

# Install kubernetes via kubeadm.
kubeadm init --apiserver-advertise-address=$NODE_IP

# Hostname -i must return a routable address on second (non-NATed) network interface.
# @see http://kubernetes.io/docs/getting-started-guides/kubeadm/#limitations
sed "s/127.0.0.1.*m/$NODE_IP m/" -i /etc/hosts

# Export k8s cluster token to an external file.
OUTPUT_FILE=/vagrant/join.sh
rm -rf /vagrant/join.sh
kubeadm token create --print-join-command > /vagrant/join.sh
chmod +x $OUTPUT_FILE