#
# Cookbook:: redis
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
remote_file '/opt/redis-3.2.11.tar.gz' do
  source 'https://s3.ap-south-1.amazonaws.com/girnarsoft-installs/redis-3.2.11.tar.gz'
  owner 'root'
  group 'root'
end

bash 'a bash script' do
  user 'root'
  code <<-EOH
  cd /opt
  tar -xvzf redis-3.2.11.tar.gz
  cd redis-3.2.11
  cd deps
  make hiredis lua jemalloc linenoise geohash-int
  cd ..
  make
  make install
  cd utils
  echo -ne '\n' | bash install_server.sh
  EOH
  not_if { File.exist?("/etc/init.d/redis_6379") }
end


execute 'start redis' do
  command 'systemctl start redis_6379'
  action :run
end
