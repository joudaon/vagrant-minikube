# -*- mode: ruby -*-
# vi: set ft=ruby :

require "yaml"

configuration = YAML.load_file("vagrant/configuration.yml")

vagrant_conf, ubuntu_conf = configuration["vagrant_conf"], configuration["ubuntu_conf"]

Vagrant.configure("2") do |config|

  # mejoramos el rendimiento con el plugin vagrant-cachier
  if vagrant_conf["cachier"] and Vagrant.has_plugin?("vagrant-cachier")
    # con varias maquinas virtuales scope = :box da problemas
    #config.cache.scope = :box
    config.cache.scope = :machine
    config.cache.synced_folder_opts = {
      owner: "_apt",
      group: "vagrant",
      # si no ponemos estas opciones da error de permisos en /tmp/vagrant-cache
      mount_options: ["dmode=777", "fmode=666"]
    }
  end

  # ansible-master
  config.vm.define ubuntu_conf["hostname"] do |ubuntu|
    ubuntu.vm.box = ubuntu_conf["box"]
    ubuntu.vm.box_url = ubuntu_conf["box_url"]
    ubuntu.vm.hostname = ubuntu_conf["hostname"]
    ubuntu.vm.network :private_network, ip: ubuntu_conf["ip"]
    if Vagrant.has_plugin?("vagrant-hosts")
      ubuntu.vm.provision :hosts, :sync_hosts => true
    end
    memory = ubuntu_conf["ram"] ? ubuntu_conf["ram"] : 1024;
    ubuntu.vm.provider "virtualbox" do |vb|
      vb.name = ubuntu_conf["hostname"]
      vb.linked_clone = true
      vb.cpus = ubuntu_conf["cpus"]
      vb.memory = memory
    end
    ubuntu.vm.synced_folder "k8s-files", "/home/vagrant/k8s-files", type: "rsync"
    ubuntu.vm.provision "shell", privileged: true, path: "provision/docker.sh"
    ubuntu.vm.provision "shell", privileged: true, path: "provision/helm.sh"
    ubuntu.vm.provision "shell", privileged: true, path: "provision/kubectl.sh"
    ubuntu.vm.provision "shell", privileged: true, path: "provision/minikube.sh"
    ubuntu.vm.provision "shell", privileged: true, path: "provision/skaffold.sh"
  end

end