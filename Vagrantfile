# -*- mode: ruby -*-
# vi: set ft=ruby :

K8S_DEV_BOX_NAME = "ridvanaltun/k8s"
K8S_DEV_BOX_VERSION = "1.0.0"

MASTER_NODE_IP_START="172.27.44.20"
WORKER_NODE_IP_START="172.27.44.10"

JOIN_TOKEN="abcdef.1234567890123456"

Vagrant.configure(2) do |config|

  (0..0).each do |i|
    config.vm.define "m" do |node|
      node.vm.box = K8S_DEV_BOX_NAME
      node.vm.box_version = K8S_DEV_BOX_VERSION

      node.vm.hostname = "m"
      node.vm.network "private_network", ip: "#{MASTER_NODE_IP_START}#{i}"

      # hostname -i must return a routable address on second (non-NATed) network interface
      # see 5) in http://kubernetes.io/docs/getting-started-guides/kubeadm/#limitations
      node.vm.provision "shell", inline: "sed 's/127.0.0.1.*m/#{MASTER_NODE_IP_START}#{i} m/' -i /etc/hosts"
      node.vm.provision "shell", inline: "echo 'cd /vagrant' >> ~/.bashrc && exit", privileged: false

      # Setup resources
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
      end
    end
  end

  (1..2).each do |i|
    config.vm.define "n#{i}" do |node|
      node.vm.box = K8S_DEV_BOX_NAME
      node.vm.box_version = K8S_DEV_BOX_VERSION

      node.vm.hostname = "n#{i}"
      node.vm.network "private_network", ip: "#{WORKER_NODE_IP_START}#{i-1}"

      # hostname -i must return a routable address on second (non-NATed) network interface
      # see 5) in http://kubernetes.io/docs/getting-started-guides/kubeadm/#limitations
      node.vm.provision "shell", inline: "sed 's/127.0.0.1.*n#{i}/#{WORKER_NODE_IP_START}#{i} n#{i}/' -i /etc/hosts"
      node.vm.provision "shell", inline: "echo 'cd /vagrant' >> ~/.bashrc && exit", privileged: false

      node.vm.provision "shell", inline: "route add 10.96.0.1 gw #{MASTER_NODE_IP_START}0 && exit", privileged: true, run: "always"

      # Setup resources
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "2048"
        vb.cpus = 2
      end
    end
  end
end
