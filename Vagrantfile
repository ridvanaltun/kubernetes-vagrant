Vagrant.configure("2") do |config|

  # enable vagrant-env (.env)
  config.env.enable

  # set constants
  IMAGE_NAME = ENV['IMAGE_NAME']
  MEMORY_SIZE_IN_GB = ENV['MEMORY_SIZE_IN_GB'].to_i
  CPU_COUNT = ENV['CPU_COUNT'].to_i
  MASTER_NODE_COUNT = ENV['MASTER_NODE_COUNT'].to_i
  WORKER_NODE_COUNT = ENV['WORKER_NODE_COUNT'].to_i
  MASTER_NODE_IP_START = ENV['MASTER_NODE_IP_START']
  WORKER_NODE_IP_START = ENV['WORKER_NODE_IP_START']

  # set variables
  master_node_ip = ''
  worker_node_ip = ''

  config.vm.box = IMAGE_NAME

  config.vm.provider "virtualbox" do |vb|

    vb.memory = 1024 * MEMORY_SIZE_IN_GB
    vb.cpus = CPU_COUNT

  end

  config.vm.provision "shell", path: "pre.sh"

  config.vm.provision "shell", path: "install-docker.sh"
  config.vm.provision "shell", path: "install-kube-tools.sh"

  config.vm.provision "shell", path: "post.sh"

  (1..MASTER_NODE_COUNT).each do |i|
    config.vm.define "m" do |master|

      master_node_ip = "#{MASTER_NODE_IP_START}#{i}"
      master.vm.network "private_network", ip: "#{master_node_ip}"
      master.vm.hostname = "m"

      # init master node.
      master.vm.provision "shell", path: "init-master-node.sh", env: {"NODE_IP" => "#{master_node_ip}"}

      # prepare kubectl for vagrant user
      master.vm.provision "shell", privileged: false, path: "prepare-kubectl.sh"

      # prepare kubectl for root user
      master.vm.provision "shell", privileged: true, path: "prepare-kubectl.sh"

      # install cni.
      master.vm.provision "shell", path: "install-cni.sh"

    end
  end

  (1..WORKER_NODE_COUNT).each do |i|
    config.vm.define "n#{i}" do |node|

      worker_node_ip = "#{WORKER_NODE_IP_START}#{i}"
      node.vm.network "private_network", ip: "#{worker_node_ip}"
      node.vm.hostname = "n#{i}"

      # init slave node.
      node.vm.provision "shell", path: "init-slave-node.sh", env: {"NODE_IP" => "#{worker_node_ip}"}

    end
  end

end