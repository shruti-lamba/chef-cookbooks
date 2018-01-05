node['nginx'].each do |h|
    v = h['vhost']
    if v.has_key?('mobile_rule_root')
      mobile_rule = true
    else
      mobile_rule = false
    end
      template "/etc/nginx/conf.d/#{v['main_domain']}.conf" do
        source '/mobiledekho/vhost_config.erb'
        owner 'root'
        group 'root'
        mode 00744
        variables(
          :server_aliases => v['aliases'],
          :docroot => v['docroot'],
          :access_log => v['access_log'],
          :error_log => v['error_log'],
          :rewrite_rule => v['rewrite_rule'],
          :location_50x => v['location_50x'],
          :jpg_rule => v['jpg_rule'],
          :mobile_rule => mobile_rule,
          :mobile_rule_root => v['mobile_rule_root']
        )
      end
end

template '/etc/nginx/nginx.conf' do
  source 'mobiledekho/nginx.conf.erb'
  owner 'root'
  group 'root'
  mode 00744
end

template '/etc/nginx/fastcgi.conf' do
  source 'mobiledekho/fastcgi.conf'
  owner 'root'
  group 'root'
  mode 00744
end

service 'nginx' do
  action :restart
end
