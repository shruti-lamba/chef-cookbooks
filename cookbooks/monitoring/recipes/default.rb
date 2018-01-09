service 'zabbix stop' do
  case node['platform']
  when 'centos','redhat','fedora'
    service_name 'zabbix-server'
  else
    service_name 'zabbix-server'
  end
  supports :restart => true
  action [ :stop, :disable ]
  only_if { File.exist?("/lib/systemd/system/zabbix-server.service") }
end

if node['platform'] == 'centos'
bash "zabbix-server-remove" do
  user 'root'
  code <<-EOH
    yum remove zabbix-* -y
    mkdir /opt/zabbix
  EOH
  not_if { ::Dir.exists?('/opt/zabbix') }
end
end

if node['platform'] == 'ubuntu'
bash "zabbix-server-remove" do
  user 'root'
  code <<-EOH
    apt-get remove zabbix-* -y
    apt-get purge zabbix-* -y
    mkdir /opt/zabbix
  EOH
  not_if { ::Dir.exists?('/opt/zabbix') }
end
end

if node['platform'] == 'centos' 
bash "install telegraf on centos" do
  user 'root'
  code <<-EOH
    wget https://dl.influxdata.com/telegraf/releases/telegraf-1.5.0-1.x86_64.rpm
    yum localinstall telegraf-1.5.0-1.x86_64.rpm -y
  EOH
  not_if {::Dir.exists?('/etc/telegraf') }
end
end

if node['platform'] == 'ubuntu'
bash "install telegraf on ubuntu" do
  user 'root'
  code <<-EOH
    wget https://dl.influxdata.com/telegraf/releases/telegraf_1.5.0-1_amd64.deb
    dpkg -i telegraf_1.5.0-1_amd64.deb
  EOH
  not_if {::Dir.exists?('/etc/telegraf') }
end
end

service "telegraf" do
  action [ :start ]
end


cookbook_file "/etc/telegraf/dashboard.json" do
  source "dashboard.json"
  owner "root"
  group "root"
  mode 00644
  action :create_if_missing
end

template '/etc/telegraf/telegraf.conf' do
  source 'telegraf.erb'
  owner "root"
  group "root"
  notifies :restart, 'service[telegraf]', :immediate
end

service "telegraf" do
  action [ :stop ]
end

cookbook_file "/usr/bin/telegraf" do
  source "telegraf"
  owner "root"
  group "root"
  mode 00755
#  action :create_if_missing
end


service "telegraf" do
  action [ :restart ]
end
