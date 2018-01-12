#
# Cookbook:: attach_ebs
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#include_recipe 'aws_volume'

#include Aws::Ec2
include_recipe 'aws'

include_recipe 'aws::ec2_hints'

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

mount '/dev/xvdf' do
  fstype 'ext4'
  mount_point '/data'
  action [:mount, :enable]
end
#aws_volume_ebs_volume "data_ebs_volume" do
#	size 30#
#device "/dev/sda"
#	volume_type "gp2"
#	action [ :create, :attach ]
#end
