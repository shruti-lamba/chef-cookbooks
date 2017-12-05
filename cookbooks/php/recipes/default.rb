#
# Cookbook:: php
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
if node['platform'] == 'ubuntu'
apt_repository 'php' do
  uri 'ppa:ondrej/php'
  distribution node["lsb"]["codename"]
end

apt_update 'apt-get-update' do
  action :update
end

package 'php7.1' do
  action :install
end
end

if node['platform'] == 'centos'
  remote_file '/opt/epel-release-latest-7.noarch.rpm' do
    source 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
    owner 'root'
    group 'root'
  end
  rpm_package 'install rpm packacge' do
    action :install
    source '/opt/epel-release-latest-7.noarch.rpm'
  end
  remote_file '/opt/webtatic-release.rpm' do
    source 'https://mirror.webtatic.com/yum/el7/webtatic-release.rpm'
    owner 'root'
    group 'root'
  end
  rpm_package 'install rpm package' do
    action :install
    source '/opt/webtatic-release.rpm'
  end
  yum_package 'php71w' do
    action :install
  end
end
