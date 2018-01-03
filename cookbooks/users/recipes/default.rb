#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
users = data_bag('users')

#execute 'enable_passwordauthentication' do
#  command "sed 's/PasswordAuthentication\ no/PasswordAuthentication\ yes/g' -i /etc/ssh/sshd_config && sudo service sshd restart"
#  only_if "grep 'PasswordAuthentication no' /etc/ssh/sshd_config"
#end


username = "#{node['users']['name']}"
#userdata = data_bag_item("users", "#{username}")
home = "/data/#{username}"
#password = userdata['password']
#enc_password = `openssl passwd -1 "#{password}" | tr -d '\n'`

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
      mode '0600'3
      owner "#{username}"
      content userdata['ssh_public_key']
end
