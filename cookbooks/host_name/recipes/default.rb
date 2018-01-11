#
# Cookbook:: hostname
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#include_recipe 'recipe[ec2-tags-ohai-plugin]'

#hname = node['ec2']['tags']['Name']
if node['platform'] ==  'centos'
  hostsfile_entry "#{node['ipaddress']}" do
    hostname  "#{node['ec2']['tags']['Name']}.girnarsoft.net"
    unique true
  end

  hostsfile_entry "#{node['ipaddress']}" do
    hostname  "#{node['ec2']['tags']['Name']}"
    action :append
  end

  execute 'set hostname' do
    command "hostnamectl set-hostname #{node['ec2']['tags']['Name']}"
    action :run
  end

  execute 'preserver hostname' do
    command 'echo "preserve_hostname: true" >> /etc/cloud/cloud.cfg'
    action :run
    not_if { File.readlines("/etc/cloud/cloud.cfg").grep(/preserve_hostname/).size > 0 }
  end
end

if node['platform'] == 'ubuntu'
execute 'set hostname' do
  command "echo #{node['ec2']['tags']['Name']}.girnarsoft.net > /etc/hostname && hostname #{node['ec2']['tags']['Name']}"
  action :run
end

hostsfile_entry "#{node['ipaddress']}" do
  hostname  "#{node['ec2']['tags']['Name']}.girnarsoft.net"
  unique    true
end

hostsfile_entry "#{node['ipaddress']}" do
  hostname  "#{node['ec2']['tags']['Name']}"
  action :append
end

execute 'preserver hostname' do
  command "sed -i 's/preserve_hostname: false/preserve_hostname: true/' /etc/cloud/cloud.cfg"
  action :run
end
end
