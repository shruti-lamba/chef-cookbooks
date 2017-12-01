template '/etc/zabbix/zabbix_agentd.conf' do
  source 'zabbix_agentd_conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

service 'zabbix-agent' do
  action :restart
end
