#
# Cookbook:: zabbix
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if node['platform'] == 'centos'
  remote_file '/opt/zabbix-release-3.2-1.el7.noarch.rpm' do
    source 'http://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm'
    owner 'root'
    group 'root'
    action :create_if_missing
  end

  yum_package 'zabbix' do
    source '/opt/zabbix-release-3.2-1.el7.noarch.rpm'
    action :install
    not_if "rpm -qa | grep zabbix-release"
  end

  yum_package 'zabbix-agent' do
    action :install
    not_if "rpm-qa | grep zabbix-agent"
  end
end

if node['platform'] == 'ubuntu'
  apt_update 'apt-get-update' do
    action :update
  end

  remote_file '/opt/zabbix-release_3.2-1+xenial_all.deb' do
    source 'http://repo.zabbix.com/zabbix/3.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.2-1+xenial_all'
    owner 'root'
    group 'root'
    action :create_if_missing
  end

  dpkg_package 'zabbix' do
    source '/opt/zabbix-release_3.2-1+xenial_all.deb'
    action :install
    not_if "dpkg -l | grep zabbix-release"
  end

  apt_update 'apt-get-update' do
    action :update
  end

  package 'zabbix-agent' do
    action :install
    not_if "dpkg -l | grep zabbix-agent"
  end
end

include_recipe 'zabbix::config'
