#
# Cookboo st?(aspnet_regiis) }:: filebeat
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if ['debian','ubuntu'].member? node[:platform]
  remote_file '/opt/filebeat-6.0.0-amd64.deb' do
    source 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.0.0-amd64.deb'
    owner 'root'
    group 'root'
    mode '0755'
    action :create_if_missing
  end
  dpkg_package 'install filebeat' do
    source '/opt/filebeat-6.0.0-amd64.deb'
    action :install
    not_if "dpkg -l | grep filebeat"
  end
end
if node['platform'] == 'centos'
  remote_file '/opt/filebeat-6.0.0-x86_64.rpm' do
    source 'https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.0.0-x86_64.rpm'
    owner 'root'
    group 'root'
    mode '0755'
    action :create_if_missing
  end

  bash "install filebeat" do
    user 'root'
    code 'sudo rpm -vi /opt/filebeat-6.0.0-x86_64.rpm'
    not_if "rpm -qa | grep filebeat"
  end
end

include_recipe 'filebeat::config'
