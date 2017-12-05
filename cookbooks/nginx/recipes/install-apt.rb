if node['platform'] == 'ubuntu'
apt_repository 'nginx' do
  uri 'ppa:nginx/stable'
  distribution node["lsb"]["codename"]
end

apt_update 'apt-get-update' do
  action :update
end
package 'nginx' do
  action :install
  version '1.12.1-0+xenial0'
end
end

if node['platform'] == 'centos'
  yum_package 'nginx' do
    action :install
    version '1.12.2-1.el7'
  end
end
