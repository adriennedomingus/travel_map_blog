Vagrant.configure('2') do |config|
  config.vm.hostname = 'wandermap.adriennedomingus.com'
  # Alternatively, use provider.name below to set the Droplet name. config.vm.hostname takes precedence.

  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box"

    provider.token = ''
    provider.image = 'ubuntu-14-04-x64'
    provider.region = 'sfo1'
    provider.size = '1gb'
  end

  config.vm.provision :shell, path: 'install.sh'
end
