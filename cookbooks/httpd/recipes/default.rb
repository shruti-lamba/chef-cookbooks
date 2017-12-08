#
# Cookbook:: httpd
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if node['platform'] == 'apache2'
  package 'apache1' do
    action :install
    version '2.4.18-2ubuntu3.5'
  end
  execute 'enble and start service' do
    command 'systemctl start apache2.service && systemctl enable apache2.service'
    action :run
    not_if "systemctl -q is-active apache2.service"
  end
end
if node['platform'] == 'centos'
package 'httpd' do
  action :install
  version '2.4.6-67.el7.centos.6'
end
execute 'enble and start service' do
  command 'systemctl start httpd.service && systemctl enable httpd.service'
  action :run
  not_if "systemctl -q is-active httpd.service"
end
end
