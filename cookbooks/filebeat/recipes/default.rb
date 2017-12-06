#
# Cookboo st?(aspnet_regiis) }:: filebeat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if node['platform'] == 'ubuntu'
  remote_file "#{node['filebeat']['pkg_path']}" do
    source "#{node['filebeat']['pkg_url']}"
    owner 'root'
    group 'root'
    mode '0755'
    action :create_if_missing
  end
  dpkg_package 'install filebeat' do
    source "#{node['filebeat']['pkg_path']}"
    action :install
    not_if "dpkg -l | grep filebeat"
  end
end

if node['platform'] == 'centos'
  remote_file "#{node['filebeat']['pkg_path']}" do
    source "#{node['filebeat']['pkg_url']}"
    owner 'root'
    group 'root'
    mode '0755'
    action :create_if_missing
  end

  rpm_package 'install filebeat rpm' do
    action :install
    source "#{node['filebeat']['pkg_path']}"
    not_if "rpm -qa | grep filebeat"
  end
end

#include_recipe 'filebeat::config'
