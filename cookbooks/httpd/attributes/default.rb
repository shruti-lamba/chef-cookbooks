if node['platform'] == 'ubuntu'
  default['httpd']['version'] = "2.4.18-2ubuntu3.5"
end

if node['platform'] == 'centos'
  default['httpd']['version'] = "2.4.6-67.el7"
end
