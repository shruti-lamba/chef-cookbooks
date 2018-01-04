#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
users = data_bag('users')

execute 'enable_passwordauthentication' do
  command "sed 's/PasswordAuthentication\ yes/PasswordAuthentication\ no/g' -i /etc/ssh/sshd_config && sudo service sshd restart"
  only_if "grep 'PasswordAuthentication yes' /etc/ssh/sshd_config"
end


username = "#{node['ec2']['tags']['Name']}".split('-')[0].downcase

if "#{username}" == "connecto"
  username = "cardekho"
end

home = "/data/#{username}"

user "#{username}" do
      shell '/bin/bash'
      home  home
      manage_home true
end

directory "#{home}/.ssh" do
      mode '0700'
      owner "#{username}"
      recursive true
end

userdata = data_bag_item("users", "jenkins")
file "#{home}/.ssh/authorized_keys" do
      mode '0600'
      owner "#{username}"
      content userdata['ssh_public_key']
end
