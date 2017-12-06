default['elk']['source_ip'] = '1.0.1.129'

if node['platform'] == 'ubuntu'
  default['filebeat']['pkg_url'] = "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.0.0-amd64.deb"
  default['filebeat']['pkg_path'] = "/opt/filebeat-6.0.0-amd64.deb"
end

if node['platform'] == 'centos'
  default['filebeat']['pkg_url'] = "https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.0.0-x86_64.rpm"
  default['filebeat']['pkg_path'] = "/opt/filebeat-6.0.0-x86_64.rpm"
end
