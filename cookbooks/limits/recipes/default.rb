#
# Cookbook:: limits
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
template "/etc/security/limits.conf" do 
	source 'limits.conf.erb' 
	mode '0644' 
	owner "root" 
	group "root" 
end
