Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/jammy64'

  config.vm.provider :virtualbox do |vb|
    vb.cpus = 1
    vb.memory = 1024
  end

  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.define :default, primary: true do |default|
    default.vm.hostname = 'vagrant.dev'
    default.vm.network :private_network, name: 'vboxnet0', ip: '192.168.56.2'
    default.vm.network :forwarded_port, id: 'ssh', host: 2222, guest: 22
    default.vm.network :forwarded_port, id: 'http', host: 8080, guest: 80
  end

  config.vm.define :backup, autostart: false do |backup|
    backup.vm.hostname = 'vagrant-backup.dev'
    backup.vm.network :private_network, name: 'vboxnet0', ip: '192.168.56.3'
    backup.vm.network :forwarded_port, id: 'ssh', host: 2223, guest: 22
  end
end
