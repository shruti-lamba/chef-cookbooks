if node['platform'] == 'centos'
execute 'yum update' do
  command "yum update -y"
  action :run
end
end

if node['platform'] == 'ubuntu'
  apt_update 'apt-get-update' do
  action :update
end
end
