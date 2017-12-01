#
# Cookbook:: awscli
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if node['platform'] == 'ubuntu'
  apt_update 'apt-get-update' do
    action :update
  end
  package 'python-pip' do
    action :install
    not_if { File.exist?("/usr/bin/pip") }
  end
  execute 'install awscli' do
    command 'pip install awscli'
    action :run
    not_if { File.exist?("/usr/local/bin/aws") }
  end
end

if node['platform'] == 'centos'
  remote_file '/opt/get-pip.py' do
    source 'https://bootstrap.pypa.io/get-pip.py'
    owner 'root'
    group 'root'
    action :create_if_missing
  end
  execute 'install pip' do
    command 'python /opt/get-pip.py'
    action :run
    not_if { File.exist?("/bin/pip") }
  end
  execute 'install awscli' do
    command 'pip install awscli'
    action :run
    not_if { File.exist?("/bin/aws") }
  end
end
