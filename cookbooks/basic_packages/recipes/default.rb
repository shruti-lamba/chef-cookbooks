#
# Cookbook:: basic_packages
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
apt_update 'apt-get-update' do
  action :update
end

if node['platform'] == 'centos'
    yum_package %w(gcc-c++ pcre-devel zlib-devel make wget openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel gperftools-devel vim mlocate sysstat git) do
      action :install
    end
end

if node['platform'] == 'ubuntu'
  package %w(build-essential zlib1g-dev libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev mlocate sysstat git) do
    action :install
  end
end
