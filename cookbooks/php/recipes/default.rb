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
  remote_file "#{node['remi-repo']['path']}" do
    source "#{node['remi-repo']['url']}"
    owner 'root'
    group 'root'
  end

  rpm_package 'install remi repo' do
    action :install
    source "#{node['remi-repo']['url']}"
  end

#  bash 'enable repo' do
#    user 'root'
#    if node['php']['version'] == 7.1
#    code <<-EOH
#    yum-config-manager --enable remi-php71
#    EOH
#    end
#    if node['php']['version'] == 5.6
#    code <<-EOH
#    yum-config-manager --enable remi-php56
#    EOH
#    end
#    action :run
#  end

#  execute 'enable remi' do
#    if node['php']['version'] == 7.1
#      command 'yum --enable remi-php71'
#    end
#    if node['php']['version'] == 5.6
#      command 'yum-config-manager --enable remi-php56'
#    end
#    action :run
#  end
#yum_package 'remi-php71' do
#  enabled  :True
#end
if node['php']['version'] == 7.1
template '/etc/yum.repos.d/remi-php71.repo' do
  source 'remi-php71.erb'
  owner 'root'
  group 'root'
  mode 00744
end
end

if node['php']['version'] == 5.6
  template '/etc/yum.repos.d/remi-php56.repo' do
    source 'remi-php56.erb'
    owner 'root'
    group 'root'
    mode 00744
  end
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
    command "systemctl enable php-fpm.service && systemctl start php-fpm.service"
    action :run
    not_if "systemctl -q is-active php-fpm.service"
  end
end
