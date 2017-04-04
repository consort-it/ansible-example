# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = false

  if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
    config.vm.synced_folder ".", "/vagrant", mount_options: ["dmode=755,fmode=644"]
  else
    config.vm.synced_folder ".", "/vagrant"
  end

  # DEMO 10.100.100.200
  config.vm.define "demo" do |box|
    box.vm.box = "ubuntu/trusty64"
    box.vm.hostname = "demo"
    box.vm.network "private_network", ip: "10.100.100.200"
    box.vm.provider "virtualbox" do |v|
      v.memory = 1024
    end
    box.vm.provision :shell, path: "scripts/bootstrap_ansible.sh"
    box.vm.provision :shell, inline: "cd /vagrant && PYTHONUNBUFFERED=1 ansible-playbook demo.yml -c local"
  end

  # VAI: A Vagrant provisioning plugin to output a usable Ansible inventory to use outside Vagrant
  # https://github.com/MatthewMi11er/vai
  config.vm.provision :vai do |ansible|
    ansible.inventory_dir = './'
    ansible.inventory_filename = 'hosts'
  end

  # vagrant-cachier: A Vagrant plugin that helps you reduce the amount of coffee you drink while waiting for boxes to be provisioned by sharing a common package cache among similar VM instances.
  # https://github.com/fgrehm/vagrant-cachier
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end
end
