node['httpd'].each do |h|
    v = h['vhost']
      if v.has_key?('aliases')
        aliases = true
      else
        aliases = false
      end
      template "/etc/httpd/conf.d/#{v['main_domain']}.conf" do
        source '/truckdekho/virtual_host.conf.erb'
        owner 'root'
        group 'root'
        mode 00744
        variables(
          :server_name => v['main_domain'],
          :aliases => aliases,
          :server_aliases => v['aliases'],
          :docroot => v['docroot'],
          :access_log => v['access_log'],
          :error_log => v['error_log'],
          :rewrite_rule => v['rewrite_rule'],
          :directory_match => v['directory_match']
        )
      end
end

service 'httpd' do
  action :restart
end
