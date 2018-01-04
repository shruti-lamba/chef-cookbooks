if node['platform'] == 'ubuntu'
  default['common']['packages'] = %w(build-essential python-software-properties zlib1g-dev pkg-config libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev mlocate sysstat git openssl)
  default['ssm-agent']['url'] = "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb"
  default['ssm-agent']['path'] = "/opt/amazon-ssm-agent.deb"
end

if node['platform'] == 'centos'
  default['common']['packages'] = %w(telnet bash-completion yum-utils bash-completion-extras gcc-c++ pcre-devel tcl zlib-devel make wget openssl-devel libxml2-devel libxslt-devel gd-devel perl-ExtUtils-Embed GeoIP-devel gperftools-devel vim mlocate sysstat git)
  default['ssm-agent']['url'] = "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_386/amazon-ssm-agent.rpm"
  default['ssm-agent']['path'] = "/opt/amazon-ssm-agent.rpm"
end

default['centos']['epel-release-url'] = "https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm"
default['centos']['epel-release-path'] = "/opt/epel-release-latest-7.noarch.rpm"

default['centos']['webstatic-release-url'] = "https://mirror.webtatic.com/yum/el7/webtatic-release.rpm"
default['centos']['webstatic-release-path'] = "/opt/webtatic-release.rpm"
