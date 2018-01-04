node['httpd'].each do |h|
    v = h['vhost']
      server_name = v['main_domain']
      docroot = v['docroot']
      access_log = v['access_log']
      error_log = v['error_log']
      if v.has_key?('aliases')
        aliases = true
        server_aliases = v['aliases']
      else
        aliases = false
      end
      template "/etc/httpd/conf.d/#{v['main_domain']}.conf" do
        source '/busdekho/virtual_host.conf.erb'
        owner 'root'
        group 'root'
        mode 00744
        variables(
          :server_name => server_name,
          :aliases => aliases,
          :server_aliases => server_aliases,
          :docroot => docroot,
          :access_log => access_log,
          :error_log => error_log,
          :rewrite_rule => v['rewrite_rule']
        )
      end
end

service 'httpd' do
  action :restart
end
