if node['platform'] == 'ubuntu'
  default['nginx']['version'] = "1.12.1-0+xenial0"
end

if node['platform'] == 'centos'
  default['nginx']['version'] = "1.12.2-1.el7"
end
