#
# Cookbook:: timezone
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if ['debian','ubuntu'].member? node[:platform]
  # Make sure it's installed. It would be a pretty broken system
  # that didn't have it.
  package "tzdata"
  template "/etc/timezone" do
    source "timezone.conf.erb"
    owner 'root'
    group 'root'
    mode 0644
    notifies :run, 'bash[dpkg-reconfigure tzdata]'
  end

  bash 'dpkg-reconfigure tzdata' do
    user 'root'
    code "sudo ln -fs /usr/share/zoneinfo/Asia/Kolkata /etc/localtime && dpkg-reconfigure -f noninteractive tzdata"
    action :nothing
  end
end


if node['platform'] == 'centos'
  bash 'change timezone' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    rm -f /etc/localtime;
    ln -s /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
    echo 'ZONE="Europe/Copenhagen"' > /etc/sysconfig/clock
    EOH
  end  
end
