#
# Cookbook:: php
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if node['platform'] == 'ubuntu'
apt_repository 'php' do
  uri 'ppa:ondrej/php'
  distribution node["lsb"]["codename"]
end

apt_update 'apt-get-update' do
  action :update
end
end

node['php']['packages'].each do |pkg|
 package pkg do
   action :install
 end
end

execute 'start & enable service' do
  if node['platform'] == 'ubuntu'
    command "systemctl start php#{node['php']['version']}-fpm.service && systemctl enable php#{node['php']['version']}-fpm.service"
    action :run
    not_if "systemctl -q is-active php#{node['php']['version']}-fpm.service"
  end
  if node['platform'] == 'centos'
    command "systemctl start php-fpm.service && systemctl enable php-fpm.service"
    action :run
    not_if "systemctl -q is-active php-fpm.service"
  end
end
