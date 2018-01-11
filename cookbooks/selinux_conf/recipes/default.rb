#
# Cookbook:: selinux_conf
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if node['platform'] == 'centos'
  selinux_state "SELinux disable" do
  action :disabled
end

execute 'selinux permissive' do
  command 'setenforce 0'
  action :run
  only_if "getenforce | grep Enforcing"
end
end
