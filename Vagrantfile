# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'cookbook-kerl2'
  config.omnibus.chef_version = '12.9.38'
  config.vm.box = 'wk8/ubuntu-14.04'

  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    # uncomment if you want a verbose run
    # chef.log_level = 'debug'

    chef.run_list = [
      'recipe[kerl2]'
    ]
  end

  if Vagrant.has_plugin?('vagrant-gatling-rsync')
    config.gatling.rsync_on_startup = false
  end
end
