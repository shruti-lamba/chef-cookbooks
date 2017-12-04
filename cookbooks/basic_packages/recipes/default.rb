#
# Cookbook:: basic_packages
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
apt_update 'apt-get-update' do
  action :update
end

if node['platform'] == 'centos'
#    remote_file '/opt/epel-release-6-8.noarch.rpm' do
#      source 'http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'
#      owner 'root'
#      group 'root'
#      action :create_if_missing
#      notifies :run, 'bash[add epel repo]'
#    end
#    bash 'add epel repo' do
#      user 'root'
#      code 'rpm -Uvh /opt/epel-release-6*.rpm'

#    end
    yum_package %w(gcc-c++ pcre-devel zlib-devel make wget openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel gperftools-devel vim mlocate sysstat git) do
      action :install
    end
end

if node['platform'] == 'ubuntu'
  package %w(build-essential zlib1g-dev libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev mlocate sysstat git) do
    action :install
  end
end
