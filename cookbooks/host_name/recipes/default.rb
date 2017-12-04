#
# Cookbook:: hostname
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#include_recipe 'recipe[ec2-tags-ohai-plugin]'

#hname = node['ec2']['tags']['Name']
if node['platform'] ==  'centos'
  bash 'add hostname' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    sed -i "s/HOSTNAME=.*/#{node['ec2']['tags']['Name']}" /etc/sysconfig/network
    hostname #{node['ec2']['tags']['Name']}
    echo "127.0.0.1 #{node['ec2']['tags']['Name']}.girnarsoft.net #{node['ec2']['tags']['Name']}"
    EOH
  end
  execute 'preserver hostname' do
    command "sed -i 's/preserve_hostname: false/preserve_hostname: true/' /etc/cloud/cloud.cfg"
    action :run
  end
end

if node['platform'] == 'ubuntu'
execute 'set hostname' do
  command "echo #{node['ec2']['tags']['Name']}.girnarsoft.net > /etc/hostname && hostname #{node['ec2']['tags']['Name']}"
  action :run
end

execute 'preserver hostname' do
  command "sed -i 's/preserve_hostname: false/preserve_hostname: true/' /etc/cloud/cloud.cfg"
  action :run
end

hostsfile_entry 'set hostname' do
   ip_address '127.0.1.1'
   hostname "#{node['ec2']['tags']['Name']}.girnarsoft.net"
   unique true
   action    :append
end
end
