if node['platform'] == 'ubuntu'
  apt_repository 'nginx' do
    uri 'ppa:nginx/stable'
    distribution node["lsb"]["codename"]
  end

  apt_update 'apt-get-update' do
    action :update
  end
end

package 'nginx' do
  action :install
  version "#{node['nginx']['version']}"
 end

execute 'enble and start service' do
  command 'systemctl start nginx.service && systemctl enable nginx.service'
  action :run
  not_if "systemctl -q is-active nginx.service"
end
