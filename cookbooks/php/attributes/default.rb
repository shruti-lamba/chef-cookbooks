default['php']['version'] = '7.1'

version = node['php']['version']

if node['platform'] == 'ubuntu'
  default['php']['packages'] = ["php#{version}-dev", "php#{version}-fpm"]
end
if node['platform'] == 'centos'
  if "#{version}" == '7.1'
      default['php']['packages'] = ["php71w-devel", "php71w-fpm", "php71w-opcache"]
  end
  if "#{version}" == '5.6'
      default['php']['packages'] = ["php56w-devel", "php56w-fpm", "php56w-opcache"]
  end
end
