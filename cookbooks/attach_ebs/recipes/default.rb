#
# Cookbook:: attach_ebs
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#include_recipe 'aws_volume'

#include Aws::Ec2

aws_ebs_volume 'data_ebs_volume' do
  size 30
  device '/dev/sdf'
  volume_type "gp2"
  action [:create, :attach]
end

#aws_volume_ebs_volume "data_ebs_volume" do
#	size 30#
#device "/dev/sda"
#	volume_type "gp2"
#	action [ :create, :attach ]
#end
