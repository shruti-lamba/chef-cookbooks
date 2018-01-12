#
# Cookbook:: attach_ebs
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
aws_ebs_volume 'db_ebs_volume' do
  size 30
  device '/dev/sdf'
  action [:create, :attach]
end
