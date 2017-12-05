#
# Cookbook:: basic_packages
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


if node['platform'] == 'centos'
#   remote_file '/opt/epel-release-6-8.noarch.rpm' do
#      source 'http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'
#      owner 'root'
#      group 'root'
#      action :create_if_missing
#    end
#    execute 'add epel repo' do
#      command 'rpm - Uvh epel-release-6-8.noarch.rpm'
#      action :run
#    end
  #  execute 'yum-update' do
  #    command 'yum update -y'
  #    action :run
  #  end
    yum_package %w(gcc-c++ pcre-devel zlib-devel epel-release make wget openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel gperftools-devel vim mlocate sysstat git) do
      action :install
    end
end

if node['platform'] == 'ubuntu'
  apt_update 'apt-get-update' do
    action :update
  end
  package %w(build-essential python-software-properties zlib1g-dev pkg-config libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev mlocate sysstat git openssl) do
    action :install
  end
end
