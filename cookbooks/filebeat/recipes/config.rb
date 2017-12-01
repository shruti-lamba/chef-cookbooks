template "/etc/filebeat/filebeat.yml" do 
  source 'filebeat.yml.erb' 
  mode '0644' 
  owner "root" 
  group "root" 
end

service "filebeat" do
  action :restart
end
