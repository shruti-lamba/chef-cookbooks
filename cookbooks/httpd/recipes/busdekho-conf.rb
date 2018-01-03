node['httpd'].each do |h|
    v = h['vhost']
      server_name = v['main_domain']
      server_aliases = v['aliases']
      docroot = v['docroot']
      access_log = v['access_log']
      error_log = v['error_log']
      template "/etc/httpd/conf.d/#{v['main_domain']}.conf" do
        source '/busdekho/virtual_host.conf.erb'
        owner 'root'
        group 'root'
        mode 00744
        variables(
          :server_name => server_name,
          :server_aliases => server_aliases,
          :docroot => docroot,
          :access_log => access_log,
          :error_log => error_log,
        )
      end
#    end
end
