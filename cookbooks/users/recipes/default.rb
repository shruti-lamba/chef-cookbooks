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


users.each do |login|
  userdata = data_bag_item('users', login)
  home = "/home/#{login}"

    user(login) do
      shell '/bin/bash'
      home      home
      manage_home  true
    end

    directory "#{home}/.ssh" do
      mode '0700'
      owner login
      recursive true
    end

    file "#{home}/.ssh/authorized_keys" do
      mode '0600'
      owner login
      content userdata['ssh_public_key']
    end

end
