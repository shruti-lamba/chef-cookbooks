#
# Cookbook:: mongodb
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if node['platform'] == 'ubuntu'
  bash 'adding gpg key and source list' do
    user 'root'
    code <<-EOH
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
    echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/#{node['mongodb']['version']} multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
    EOH
    not_if { File.exist?("/usr/bin/mongod")}
  end

  apt_update 'apt-get-update' do
    action :update
  end

  package 'mongodb-org' do
    action :install
    not_if { File.exist?("/usr/bin/mongod")}
  end

  cookbook_file '/etc/systemd/system/mongod.service' do
    source 'mongod.service'
    owner 'root'
    group 'root'
    mode '0755'
    action :create_if_missing
    notifies :run, 'execute[enable mongod service]', :immediately
    not_if { File.exist?("/usr/bin/mongod")}
  end

  execute 'enable mongod service' do
    user 'root'
    command 'systemctl start mongod.service && systemctl enable mongod.service'
    action :nothing
  end
end

if node['platform'] == 'centos'
  template "/etc/yum.repos.d/mongodb-org-#{node['mongodb']['version']}.repo" do
    source 'mongodb-repo.erb'
    owner 'root'
    group 'root'
    mode 00744
    not_if { File.exist?("/bin/mongod")}
  end
  yum_package 'mongodb-org' do
    action :install
    not_if { File.exist?("/bin/mongod")}
  end
end
