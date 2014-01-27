# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "debian-7.2.0"
    config.vm.box_url = "/Users/ramble/Development/debian-7.2.0.box"
    config.vm.network :private_network, ip: "10.10.10.5"

    config.vm.hostname = "emarref.dev.local"

    config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "1024"]
    end

    # config.vm.provision "shell", inline: "apt-get update"

    config.vm.provision :puppet do |puppet|
        puppet.module_path       = "modules"
        puppet.manifests_path    = "."
        puppet.manifest_file     = "site.pp"
        puppet.hiera_config_path = "./hiera.yaml"
        puppet.options           = "--environment dev"
    end

end
