#
# Cookbook:: node
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
apt_update 'apt-get-update' do
  action :update
end
include_recipe 'nvm'

nvm_install 'v0.10.5'  do
  from_source false
  alias_as_default true
  action :create
end
