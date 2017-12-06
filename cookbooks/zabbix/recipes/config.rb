template '/etc/zabbix/zabbix_agentd.conf' do
  source 'zabbix_agentd_conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

if node['platform'] == 'centos'
  execute 'selinux permissive' do
    command 'setenforce 0'
    action :run
  end
end
service 'zabbix-agent' do
  action :restart
end
