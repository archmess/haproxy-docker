# -*- mode: ruby -*-
# vi: set ft=ruby :

# Set the number of docker hosts you want
$nodeCount = 2

Vagrant.require_version ">= 1.7.0"
Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "512" # Need testing to ensure we use the minimum
  end

  # Create several docker host to run a docker container which we load-balance with.
  # There is probably better solution but this is used only as experimentation.
  (1..$nodeCount).each do |i|
    config.vm.define "docker-host-#{i}" do |dockerHost|
      dockerHost.vm.box = "ubuntu/xenial64"
      dockerHost.vm.network "private_network", ip: "192.168.0.1#{i}"
      dockerHost.vm.provision "shell", inline: "sudo apt-get update && sudo apt-get install -y python-pip"
      dockerHost.vm.provision "ansible_local" do |ansible|
        ansible.provisioning_path = "/vagrant/src/ansible/docker-host"
        ansible.galaxy_role_file = "requirements.yml"
        ansible.playbook = "playbook.yml"
      end
    end
  end

  # Define a box on which we will install HAProxy to load-balance with every docker hosts
  # On purpose, script with shell the installation for learning
  config.vm.define "haproxy" do |haproxy|
    haproxy.vm.box = "ubuntu/xenial64"
    haproxy.vm.network "private_network", ip: "192.168.0.10"
    haproxy.vm.provision "shell" do |s|
      s.path = "src/scripts/haproxy.sh"
      s.args = $nodeCount
    end
  end

end
