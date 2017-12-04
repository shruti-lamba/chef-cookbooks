#
# Cookbook:: hostname
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#include_recipe 'recipe[ec2-tags-ohai-plugin]'

#hname = node['ec2']['tags']['Name']

execute 'set hostname' do
  command "echo #{node['ec2']['tags']['Name']}.girnar.com > /etc/hostname && hostname #{node['ec2']['tags']['Name']}.girnar.com "
  action :run
end

execute 'preserver hostname' do
  command "sed -i 's/preserve_hostname: false/preserve_hostname: true/' /etc/cloud/cloud.cfg"
  action :run
end

hostsfile_entry 'set hostname' do
   ip_address '127.0.1.1'
   hostname "#{node['ec2']['tags']['Name']}.girnar.com"
   unique true
   action    :append
end
