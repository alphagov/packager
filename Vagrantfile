# -*- mode: ruby -*-
# vi: set ft=ruby:

MEMSIZE = "1024"
NCPU = "2"
#
# NB: please don't use ruby 1.9 syntax in this file until the default system
#     ruby shipping with Mac OS X becomes ruby 1.9
#
DIST_PREFERRED = 'trusty'
LATEST_BOX_VERSIONS = {
  'precise' => '20140829',
  'trusty'  => '20140829',
}

Vagrant.configure("2") do |config|

  config.vm.hostname = "packager"

  default_box = "govuk_dev_#{DIST_PREFERRED}64_#{LATEST_BOX_VERSIONS[DIST_PREFERRED]}"

  config.vm.provider :virtualbox do |vb|
    vb.customize [ "modifyvm", :id, "--memory", MEMSIZE, "--cpus", NCPU ]
    vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
  end

  config.vm.provider :vmware_fusion do |f, override|
    default_box = "govuk_dev_#{DIST_PREFERRED}64_vmware_fusion_#{LATEST_BOX_VERSIONS[DIST_PREFERRED]}"
    f.vmx["memsize"] = MEMSIZE
    f.vmx["numvcpus"] = NCPU
  end

  config.vm.box = default_box
  config.vm.box_url = "http://gds-boxes.s3.amazonaws.com/#{default_box}.box"

  config.vm.synced_folder ".", "/home/vagrant/packager"

  $stderr.puts "WARNING: The guest has access to your ~/.gnupg directory"
  config.vm.synced_folder "~/.gnupg", "/home/vagrant/.gnupg"

  config.vm.provision :shell, :path => "tools/bootstrap"

  if File.exist? 'Vagrantfile.local'
    instance_eval File.read('Vagrantfile.local'), 'Vagrantfile.local'
  end

end
