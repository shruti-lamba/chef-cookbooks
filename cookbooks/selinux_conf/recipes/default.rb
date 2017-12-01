#
# Cookbook:: selinux_conf
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if node['platform'] == 'centos'
  selinux_state "SELinux disable" do
  action :disabled
end
end
