node['nginx'].each do |h|
    v = h['vhost']
      template "/etc/nginx/sites-enabled/#{v['main_domain']}.conf" do
        source '/pricedekho/vhost_config.erb'
        owner 'root'
        group 'root'
        mode 00744
        variables(
          :server_aliases => v['aliases'],
          :docroot => v['docroot'],
          :aliases => v['aliases']
          :access_log => v['access_log'],
          :error_log => v['error_log'],
          :new_rule => v['rewrite_rule'],
        )
      end
end

template '/etc/nginx/sites-enabled/elb-healthcheck.conf' do
  source 'pricedekho/elb_healthcheck.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

template '/etc/nginx/sites-enabled/upstream_phpfpm.conf' do
  source 'pricedekho/upstream_phpfpm.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

service 'nginx' do
  action :restart
end
