template '/etc/httpd/conf.d/fastcgi.conf' do
  source 'truckdekho/fastcgi.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

template '/etc/httpd/conf/httpd.conf' do
  source 'truckdekho/httpd.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

service 'httpd' do
  action :restart
end
