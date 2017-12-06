#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
users = data_bag('users')

#Chef::Recipe.send(:include, OpenSSLCookbook::RandomPassword)

#password = 'xyz'
#salt = random_password(length: 10)
#crypt_password = password.crypt("$6$#{salt}")

#user 'newuser' do
#  password crypt_password
#end
#Enable PasswordAuthentication
execute 'enable_passwordauthentication' do
  command "sed 's/PasswordAuthentication\ no/PasswordAuthentication\ yes/g' -i /etc/ssh/sshd_config"
  only_if "grep 'PasswordAuthentication no' /etc/ssh/sshd_config"
end






#user 'cardekho' do
#  home '/home/cardekho'
#  shell '/bin/bash'
#  manage_home true
#end

#execute 'add sudoers entry' do
#  command 'echo "cardekho            ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers'
#  action :run
#end


#users.each do |login|

username = "#{node['ec2']['tags']['Name']}".split('-')[0].downcase
userdata = data_bag_item("users", "#{username}")
home = "/data"
password = userdata['password']
enc_password = `openssl passwd -1 "#{password}" | tr -d '\n'`

user "#{usern}" do
      shell '/bin/bash'
      home      home
      manage_home  true
      password "#{enc_password}"
end

directory "#{home}/.ssh" do
      mode '0700'
      owner "#{usern}"
      recursive true
end

userdata = data_bag_item("users", "jenkins")
file "#{home}/.ssh/authorized_keys" do
      mode '0600'
      owner "#{username}"
      content userdata['ssh_public_key']
end
