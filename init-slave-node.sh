#!/bin/bash

# Join kubernetes cluster.
/vagrant/join.sh
echo "Environment='KUBELET_EXTRA_ARGS=--node-ip=$NODE_IP'" | tee -a /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl restart kubelet