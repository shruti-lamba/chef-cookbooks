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

if node['platform'] == 'centos'
template '/etc/pki/rpm-gpg/RPM-GPG-KEY-remi' do
  source 'RPM-GPG-KEY-remi.erb'
  owner 'root'
  group 'root'
  mode 00744
end

template '/etc/yum.repos.d/remi.repo' do
  source 'remi-repo.erb'
  owner 'root'
  group 'root'
  mode 00744
end

if "#{node['php']['version']}" == '7.1'
template '/etc/yum.repos.d/remi-php71.repo' do
  source 'remi-php71.erb'
  owner 'root'
  group 'root'
  mode 00744
end
end

if "#{node['php']['version']}" == '5.6'
  template '/etc/yum.repos.d/remi-php56.repo' do
    source 'remi-php56.erb'
    owner 'root'
    group 'root'
    mode 00744
  end
end

end

 package "%w(#{node['php']['packages']})" do
   action :install
   flush_cache before: true
 end

execute 'start & enable service' do
  if node['platform'] == 'ubuntu'
    command "systemctl start php#{node['php']['version']}-fpm.service && systemctl enable php#{node['php']['version']}-fpm.service"
    action :run
    not_if "systemctl -q is-active php#{node['php']['version']}-fpm.service"
  end
  if node['platform'] == 'centos'
    command "systemctl enable php-fpm.service && systemctl start php-fpm.service"
    action :run
    not_if "systemctl -q is-active php-fpm.service"
  end
end
