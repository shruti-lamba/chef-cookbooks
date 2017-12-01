#
# Cookbook:: hostname
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
include_recipe 'recipe[ec2-tags-ohai-plugin]'

hname = node['ec2']['tags']['Name']

execute 'test' do
  command "echo #{node['ec2']['tags']['Name']} >> /home/ubuntu/test"
  action :run
end
