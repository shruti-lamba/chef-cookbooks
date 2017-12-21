default['php']['version'] = '7.1'

version = node['php']['version']

if node['platform'] == 'ubuntu'
  default['php']['packages'] = ["php#{version}-dev", "php#{version}-fpm", "php#{version}-bcmath", "php#{version}-dba", "php#{version}-enchant", "php#{version}-gd", "php#{version}-imap", "php#{version}-intl", "php#{version}-ldap", "php#{version}-mbstring", "php#{version}-mcrypt", "php#{version}-mysql", "php#{version}-odbc", "php#{version}-pgsql", "php#{version}-snmp", "php#{version}-soap", "php#{version}-tidy", "php#{version}-xml"]
end
if node['platform'] == 'centos'
  default['php']['packages'] = ["php-devel" "php-fpm" "php-bcmath" "php-dba" "php-enchant" "php-gd" "php-imap" "php-intl" "php-ldap" "php-mbstring" "php-mcrypt" "php-mysql" "php-odbc" "php-pgsql" "php-snmp" "php-soap" "php-tidy" "php-xml"]
  default['remi-repo']['url'] = "http://rpms.famillecollet.com/enterprise/remi-release-7.rpm"
  default['remi-repo']['path'] = "/opt/remi-release-7.rpm"
end
if node['php']['version'] == 7.1
  default['enable-remi']['php-version'] = "remi-php71"
end
if node['php']['version'] == 5.6
  default['enable-remi']['php-version'] = "remi-php56"
end
