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
  cd /opt/redis-3.2.11
  make
  make install
  cd utils
  bash install_server.sh <<!
  6379
  /etc/redis/redis.conf
  /var/log/redis.log
  /var/lib/redis/redis
  /usr/local/bin/redis-server
  !
  EOH
  not_if { File.exist?("/etc/init.d/redis_6379") }
end

template '/etc/redis/redis.conf' do
  source '6379.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end
execute 'start redis' do
  command 'systemctl start redis_6379'
  action :run
end
