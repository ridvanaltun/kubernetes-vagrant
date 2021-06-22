# Kubernetes Vagrant

Deploy a Kubernetes cluster using Vagrant.

# Table of Contents

- [Kubernetes Vagrant](#kubernetes-vagrant)
- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Before Start](#before-start)
- [Example Usage](#example-usage)
- [FAQ](#faq)

# Overview

- *Image:* bento/ubuntu-18.04
- *Docker Version:* 20.10.7~3-0
- *Kubelet Version:* 1.21.2-00
- *Kubectl Version:* 1.21.2-00
- *Kubeadm Version:* 1.21.2-00
- *CNI:* Flannel (Latest Version)

# Before Start

```bash
# Install the plugin for Vagrant to ability to use environment files.
$ vagrant plugin install vagrant-env

# Clone the project and go into it.
$ git clone https://github.com/ridvanaltun/kubernetes-vagrant.git && cd kubernetes-vagrant

# Customize your own environment file.
$ cp .env.example .env
```

# Example Usage

```bash
# Up one master and two worker node.
# This takes approximately ~15 minutes if you using first time.
$ vagrant up m n1 n2

# Connect to master node over SSH.
$ vagrant ssh m

# List nodes.
$ kubectl get nodes
```

# FAQ

**Why Bento?**
- Because HashiCorp (the makers of Vagrant) recommends the Bento Ubuntu.

**Why are the versions fixed?**
- Because major changes over the packages may broke the setup.

**I got error like `Call to WHvSetupPartition failed`, What should I do?**
- Disable Hyper-V on your machine with below steps:
- RUN > CMD > `bcdedit /set hypervisorlaunchtype off`, then reboot your machine.

**How can I re-activete Hyper-V?**
- RUN > CMD > `bcdedit /set hypervisorlaunchtype auto`, then reboot your machine.