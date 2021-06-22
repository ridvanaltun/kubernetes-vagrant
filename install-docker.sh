#!/bin/bash

# Install packages to allow apt to use a repository over HTTPS.
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Add Docker apt repository.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update

# Install Docker CE.
apt-get install -y \
  containerd.io=1.4.6-1 \
  docker-ce=5:20.10.7~3-0~ubuntu-$(lsb_release -cs) \
  docker-ce-cli=5:20.10.7~3-0~ubuntu-$(lsb_release -cs)

# Setup daemon.
cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

mkdir -p /etc/systemd/system/docker.service.d

# Restart and enable docker service.
systemctl daemon-reload
systemctl start docker
systemctl enable docker

# Hold Docker at this specific version.
apt-mark hold docker-ce