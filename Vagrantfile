# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "debian/jessie64"
  config.vm.hostname = "janus"
  config.vm.network "private_network", ip: "192.168.33.11"

  config.vm.provision :shell, path: "bootstrap.sh"

  config.vbguest.auto_update = false
  config.vbguest.no_remote = true

  config.vm.synced_folder "shared/", "/vagrant", disabled: true

end
