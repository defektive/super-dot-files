# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "archlinux/archlinux"

  config.vm.provision "bootstrap", type: "shell", run: "once", path: "provisioners/bootstrap.sh"
  config.vm.provision "bootstrap_user", type: "shell", run: "once", privileged: false, path: "provisioners/bootstrap_user.sh"

  config.vm.provision "aur", type: "shell", run: "once", privileged: false, path: "provisioners/install_aur.sh"
  config.vm.provision "desktop", type: "shell", run: "once", privileged: false, path: "provisioners/install_desktop.sh"
  config.vm.provision "blackarch", type: "shell", run: "once", path: "provisioners/install_blackarch.sh"

  # config.vm.provision :shell, path: "setup/update.sh", run: "always"
  config.ssh.forward_x11 = true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "4096"
    vb.customize ["modifyvm", :id, "--monitorcount", "1"]

    # EFI boot
    # vb.customize ["modifyvm", :id, "--firmware", "efi64"]

    # disable audio
    # vb.customize ["modifyvm", :id, "--audio", "none"]

    # better video
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    vb.customize ["modifyvm", :id, "--vram", "256"]

    # integration with desktop
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]

    vb.customize ["modifyvm", :id, "--cpus", "4"]
  end
end
