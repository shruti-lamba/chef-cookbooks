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
