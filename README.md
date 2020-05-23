# Kubernetes Vagrant

Manage a kubernetes cluster with Vagrant.

## Table of Contents

- [Kubernetes Vagrant](#kubernetes-vagrant)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Example Usage](#example-usage)

## Overview

- *Image:* bento/ubuntu-18.04
- *Docker Version:* 19.03.8-3-0
- *Kubectl Version:* 1.18.2-00
- *Kubeadm Version:* 1.18.2-00

## Example Usage

```bash
# up one master and two worker node
$ vagrant up m n1 n2

# connect to master node
$ vagrant ssh m

# use root user before proceed to kubectl
$ sudo su

# list nodes
$ kubectl get nodes
```