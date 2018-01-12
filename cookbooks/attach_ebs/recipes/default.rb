#
# Cookbook:: attach_ebs
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#include_recipe 'aws_volume'

#include Aws::Ec2
include_recipe 'aws'

include_recipe 'aws::ec2_hints'

chef_gem 'aws-sdk' do
  action :install
end

aws_ebs_volume 'data_ebs_volume' do
  size 30
  device '/dev/sdf'
  volume_type "gp2"
  action [:create, :attach]
end

directory '/data' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

execute 'make filesystem' do
  command 'sudo mkfs -t ext4 /dev/xvdf'
  action :run
  not_if "file -s /dev/xvdf | grep ext4"
end

execute 'mount ebs' do
  command 'mount /dev/xvdf /data'
  action :run
  not_if "df -h|grep xvdf"
end

execute 'fstab entry' do
  command "echo '/dev/xvdf /data ext4 defaults 0 0' >> /etc/fstab"
  action :run
  not_if 'cat /etc/fstab|grep /dev/xvdf'
end
#aws_volume_ebs_volume "data_ebs_volume" do
#	size 30#
#device "/dev/sda"
#	volume_type "gp2"
#	action [ :create, :attach ]
#end
