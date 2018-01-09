template '/etc/httpd/conf.d/castrol.conf' do
  source 'futuredekho/castrol.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

template '/etc/httpd/conf.d/futuredekho.conf' do
  source 'futuredekho/futuredekho.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

template '/etc/httpd/conf.d/fastcgi.conf' do
  source 'futuredekho/fastcgi.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

template '/etc/httpd/conf.d/php.conf' do
  source 'futuredekho/php.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

template '/etc/httpd/conf/httpd.conf' do
  source 'futuredekho/httpd.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

service 'httpd' do
  action :restart
end
