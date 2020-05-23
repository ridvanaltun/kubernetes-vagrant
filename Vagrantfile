IMAGE_NAME = "bento/ubuntu-18.04"
MEMORY_SIZE_IN_GB = 2
CPU_COUNT = 2
SLAVE_NODE_COUNT = 2

Vagrant.configure("2") do |config|

  config.vm.box = IMAGE_NAME
  config.vm.provider "virtualbox" do |vb|

    vb.memory = 1024 * MEMORY_SIZE_IN_GB
    vb.cpus = CPU_COUNT

  end

  config.vm.provision "shell", path: "pre.sh"

  # should reload after dist-upgrade.
  config.vm.provision :reload

  config.vm.provision "shell", path: "install-docker.sh"
  config.vm.provision "shell", path: "install-kube-tools.sh"

  config.vm.provision "shell", path: "post.sh"

  config.vm.define "m" do |master|

    master.vm.network "private_network", ip: "10.0.0.10"
    master.vm.hostname = "m"

    # init master node.
    master.vm.provision "shell", path: "init-master-node.sh"

    # prepare kubectl for vagrant user
    master.vm.provision "shell", privileged: false, path: "prepare-kubectl.sh"

    # prepare kubectl for root user
    master.vm.provision "shell", privileged: true, path: "prepare-kubectl.sh"

    # install cni.
    master.vm.provision "shell", path: "install-cni.sh"

  end

  (1..SLAVE_NODE_COUNT).each do |i|
    config.vm.define "n#{i}" do |node|

      node.vm.network "private_network", ip: "10.0.0.#{i + 11}"
      node.vm.hostname = "n#{i}"

      # init slave node.
      node.vm.provision "shell", path: "init-slave-node.sh"

      # prepare kubectl for vagrant user
      node.vm.provision "shell", privileged: false, path: "prepare-kubectl.sh"

      # prepare kubectl for root user
      node.vm.provision "shell", privileged: true, path: "prepare-kubectl.sh"

    end
  end

end