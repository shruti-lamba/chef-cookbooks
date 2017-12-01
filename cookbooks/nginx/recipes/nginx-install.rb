#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.
#apt_update 'update' d


if node['platform'] == 'centos'
    yum_package %w(gcc-c++ pcre-devel zlib-devel make wget openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel gperftools-devel) do
      action :install
    end
end

if node['platform'] == 'ubuntu'
  apt_update 'apt-get-update' do
    action :update
  end
  package %w(build-essential zlib1g-dev libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev) do
    action :install
  end
end

  remote_file '/opt/nginx-1.12.2.tar.gz' do
    source 'http://nginx.org/download/nginx-1.12.2.tar.gz'
    owner 'root'
    group 'root'
    mode '0755'
    action :create_if_missing
  end

  remote_file '/opt/pcre-8.41.tar.gz' do
    source 'ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.41.tar.gz'
    owner 'root'
    group 'root'
    mode '0755'
    action :create_if_missing
  end

  bash "pcre compile" do
    code <<-EOH
    cd /opt
    tar -zxf pcre-8.41.tar.gz
    cd pcre-8.41
    ./configure
    make
    make install
  EOH
  not_if { File.exist?("/etc/init.d/nginx") }
  end

  remote_file '/opt/zlib-1.2.11.tar.gz' do
    source 'http://zlib.net/zlib-1.2.11.tar.gz'
    owner 'root'
    group 'root'
    mode '0755'
    action :create_if_missing
  end

  bash "zlib compile" do
    code <<-EOH
    cd /opt
    tar -zxf zlib-1.2.11.tar.gz
    cd zlib-1.2.11
    ./configure
    make
    make install
    EOH
    not_if { File.exist?("/etc/init.d/nginx") }
  end

  remote_file '/opt/openssl-1.0.2k.tar.gz' do
    source 'http://www.openssl.org/source/openssl-1.0.2k.tar.gz'
    owner 'root'
    group 'root'
    mode '0755'
    action :create_if_missing
  end

  bash "openssl compile" do
    code <<-EOH
    cd /opt
    tar -zxf openssl-1.0.2k.tar.gz
    cd openssl-1.0.2k
    ./config
    make
    make install
    EOH
    not_if { File.exist?("/etc/init.d/nginx") }
  end

  bash "nginx_compile" do
    code <<-EOH
    cd /opt
    tar zxf nginx-1.12.2.tar.gz
    cd /opt/nginx-1.12.2
    ./configure --prefix=/usr/share/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/run/nginx.pid --lock-path=/var/lock/nginx.lock --http-client-body-temp-path=/var/lib/nginx/body --http-fastcgi-temp-path=/var/lib/nginx/fastcgi --http-proxy-temp-path=/var/lib/nginx/proxy --http-scgi-temp-path=/var/lib/nginx/scgi --http-uwsgi-temp-path=/var/lib/nginx/uwsgi --with-openssl=../openssl-1.0.2k --with-pcre=../pcre-8.41 --with-zlib=../zlib-1.2.11 --with-threads --with-file-aio --with-ipv6 --with-http_ssl_module --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_xslt_module --with-http_image_filter_module --with-http_geoip_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_auth_request_module --with-http_random_index_module --with-http_secure_link_module --with-http_slice_module --with-http_degradation_module --with-http_stub_status_module --with-http_perl_module --with-mail --with-mail_ssl_module --with-stream --with-stream_ssl_module --with-google_perftools_module --with-cpp_test_module --with-debug
    make
    make install
    EOH
    not_if { File.exist?("/etc/init.d/nginx") }
  end

  directory '/etc/nginx/sites-enabled' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  directory '/etc/nginx/sites-available' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  directory '/var/lib/nginx' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  cookbook_file '/etc/init.d/nginx' do
    source 'nginx'
    owner 'root'
    group 'root'
    mode '0755'
  end

  cookbook_file '/etc/systemd/system/nginx.service' do
    source 'nginx.service'
    owner 'root'
    group 'root'
    mode '0755'
    action :create_if_missing
    notifies :run, 'execute[enable nginx service]', :immediately
  end

  execute 'enable nginx service' do
    user 'root'
    command 'systemctl start nginx.service && systemctl enable nginx.service'
    action :nothing
  end
