Vagrant.configure(2) do |config|
  config.vm.box = 'nrclark/xenial64-minimal-libvirt'
  #config.vm.box = 'ubuntu/xenial64' # for base, not libvirt
  #config.vm.box = 'aravind/xenial-lxc-amd64' # for lxc

  config.vm.define :gobgp1 do |gobgp1|
    gobgp1.vm.hostname = "gobgp1"
    # outer network
    #gobgp1.vm.network "private_network", ip: "10.0.12.10", netmask: "255.255.255.0", lxc__bridge_name: 'vlxcbr1'
    gobgp1.vm.network "private_network", ip: "10.0.12.10", netmask: "255.255.255.0"
    # basic setup
    # Workaround for ansible python on minimal install
    gobgp1.vm.provision "shell", inline: "which python || sudo apt -y install python"
    gobgp1.vm.provision "shell", inline: "which aptitude || sudo apt -y install aptitude"
    gobgp1.vm.provision "shell", privileged: true, path: "./setup-gohome.sh"
    gobgp1.vm.provision :ansible do |ansible|
      ansible.limit = "all"
      ansible.playbook = "playbook.yml"
    end
    gobgp1.vm.provision "shell", privileged: true, path: "./config/gobgp1/config-interface.sh"
    gobgp1.vm.synced_folder "./config/gobgp1", "/root/config"
    gobgp1.vm.provision "shell", privileged: true, inline: "goplane -f ~/config/multiple-sites.conf"
  end

  config.vm.define :gobgp2 do |gobgp2|
    gobgp2.vm.hostname = "gobgp2"
    # outer network
    gobgp2.vm.network "private_network", ip: "10.0.12.20", netmask: "255.255.255.0"
    gobgp2.vm.network "private_network", ip: "10.0.23.20", netmask: "255.255.255.0"
    # basic setup
    # Workaround for ansible python on minimal install
    gobgp2.vm.provision "shell", inline: "which python || sudo apt -y install python"
    gobgp2.vm.provision "shell", inline: "which aptitude || sudo apt -y install aptitude"
    gobgp2.vm.provision "shell", privileged: true, path: "./setup-gohome.sh"
    gobgp2.vm.provision :ansible do |ansible|
      ansible.limit = "all"
      ansible.playbook = "playbook.yml"
    end
    gobgp2.vm.provision "shell", privileged: true, path: "./config/gobgp2/config-interface.sh"
    gobgp2.vm.synced_folder "./config/gobgp2", "/root/config"
    gobgp2.vm.provision "shell", privileged: true, inline: "goplane -f ~/config/multiple-sites.conf"
  end

  config.vm.define :gobgp3 do |gobgp3|
    gobgp3.vm.hostname = "gobgp3"
    # outer network
    gobgp3.vm.network "private_network", ip: "10.0.23.10", netmask: "255.255.255.0"
    # basic setup
    # Workaround for ansible python on minimal install
    gobgp3.vm.provision "shell", inline: "which python || sudo apt -y install python"
    gobgp3.vm.provision "shell", inline: "which aptitude || sudo apt -y install aptitude"
    gobgp3.vm.provision "shell", privileged: true, path: "./setup-gohome.sh"
    gobgp3.vm.provision :ansible do |ansible|
      ansible.limit = "all"
      ansible.playbook = "playbook.yml"
    end
    gobgp3.vm.provision "shell", privileged: true, path: "./config/gobgp3/config-interface.sh"
    gobgp3.vm.synced_folder "./config/gobgp3", "/root/config"
    gobgp3.vm.provision "shell", privileged: true, inline: "goplane -f ~/config/multiple-sites.conf"
  end
end
