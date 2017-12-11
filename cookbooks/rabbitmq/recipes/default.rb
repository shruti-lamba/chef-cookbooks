#
# Cookbook:: rabbitmq
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

if node['platform'] == 'centos'
  remote_file "#{node['erlang-rpm']['path']}" do
    source "#{node['erlang-rpm']['url']}"
    owner 'root'
    group 'root'
  end

  rpm_package 'install erlang-rpm' do
    action :install
    source "#{node['erlang-rpm']['path']}"
    not_if "rpm -qa | grep erlang"
  end

  package %w(erlang socat) do
    action :install
    not_if "rpm -qa | grep erlang"
  end

  remote_file "#{node['rabbitmq-repo']['path']}" do
    source "#{node['rabbitmq-repo']['url']}"
    owner 'root'
    group 'root'
  end

  rpm_package 'rabbitmq-rpm' do
    action :install
    source "#{node['rabbitmq-repo']['path']}"
    not_if "rpm -qa | grep rabbitmq-server"
  end

  package 'rabbitmq-server' do
    action :install
  end

  execute 'start enable rabbitmq-server' do
    command 'systemctl start rabbitmq-server && systemctl enable rabbitmq-server'
    action :run
  end
end


if node['platform'] == "ubuntu"

  remote_file "#{node['erlang-deb']['path']}" do
    source "#{node['erlang-deb']['url']}"
    owner 'root'
    group 'root'
  end

  dpkg_package 'install deb' do
    action :install
    source "#{node['erlang-deb']['path']}"
  end

  apt_update 'apt-get-update' do
    action :update
  end

  package %w(erlang, erlang-nox) do
    action :install
  end
  
  bash 'add source list and key' do
    user 'root'
    code <<-EOH
    echo "deb https://dl.bintray.com/rabbitmq/debian xenial main" | sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list
    wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
    EOH
  end

  apt_update do
    action :update
  end

  apt_package 'rabbitmq-server' do
    action :install
  end
end
