#
# Cookbook:: basic_packages
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


if node['platform'] == 'centos'
  remote_file "#{node['centos']['epel-release-path']}" do
    source "#{node['centos']['epel-release-url']}"
    owner 'root'
    group 'root'
  end

  rpm_package 'install epel-release rpm packacge' do
    action :install
    source "#{node['centos']['epel-release-path']}"
  end

  remote_file "#{node['centos']['webstatic-release-path']}" do
    source "#{node['centos']['webstatic-release-url']}"
    owner 'root'
    group 'root'
  end

  rpm_package 'install webstatic-release rpm package' do
    action :install
    source "#{node['centos']['webstatic-release-path']}"
  end

  remote_file "#{node['ssm-agent']['path']}" do
    source "#{node['ssm-agent']['url']}"
    owner 'root'
    group 'root'
  end

  rpm_package 'install ssm agent' do
    action :install
    source "#{node['ssm-agent']['path']}"
  end

  execute 'yum update' do
    command "yum update -y"
    action :run
  end
end

if node['platform'] == 'ubuntu'
  apt_update 'apt-get-update' do
    action :update
  end

  remote_file "#{node['ssm-agent']['path']}" do
    source "#{node['ssm-agent']['url']}"
    owner 'root'
    group 'root'
  end

  dpkg_package 'install ssm agent' do
    action :install
    source "#{node['ssm-agent']['path']}"
  end
end

node['common']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end
