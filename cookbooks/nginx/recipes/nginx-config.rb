template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

template '/etc/nginx/sites-enabled/default' do
  source 'default.erb'
  owner 'root'
  group 'root'
  mode 00744
end

service 'nginx' do
  action :restart
end
