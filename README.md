# Kubernetes Vagrant

Manage a kubernetes cluster with Vagrant.

## Table of Contents

- [Kubernetes Vagrant](#kubernetes-vagrant)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Before Start](#before-start)
  - [Example Usage](#example-usage)

## Overview

- *Image:* bento/ubuntu-18.04
- *Docker Version:* 19.03.8-3-0
- *Kubectl Version:* 1.18.2-00
- *Kubeadm Version:* 1.18.2-00

## Before Start

```bash
# Necessary for use .env file.
$ vagrant plugin install vagrant-env

# Clone project and go into it.
$ git clone https://github.com/ridvanaltun/kubernetes-vagrant.git && cd kubernetes-vagrant

# Set your own environment file.
$ cp .env.example .env
```

## Example Usage

```bash
# up one master and two worker node
$ vagrant up m n1 n2

# connect to master node
$ vagrant ssh m

# list nodes
$ kubectl get nodes
```