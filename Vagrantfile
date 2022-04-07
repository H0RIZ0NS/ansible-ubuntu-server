Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/focal64'

  config.vm.provider 'virtualbox' do |vb|
    vb.cpus = 1
    vb.memory = 1024
  end

  config.vm.network :forwarded_port, host: 2222, guest: 22, id: 'ssh'

  config.vm.synced_folder '.', '/vagrant', disabled: true

  config.vm.provision 'shell', inline: <<~SCRIPT
    deluser --remove-home ubuntu || true
    sed --in-place --regexp-extended 's/^PasswordAuthentication no$/#PasswordAuthentication yes/' /etc/ssh/sshd_config
    service ssh restart
  SCRIPT
end
