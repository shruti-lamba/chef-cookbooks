#
# Cookbook:: swap-file
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

execute "add_swap" do
  command "mkswap /dev/xvdz && swapon /dev/xvdz"
  action :run
  not_if 'cat /proc/swaps|grep /dev/xvdz', :user => 'root'
end

execute "add_entry_in_fstab" do
  command "echo '/dev/xvdz               swap                    swap    defaults        0 0' >> /etc/fstab"
  action :run
  not_if 'cat /etc/fstab|grep /dev/xvdz', :user => 'root'
end
