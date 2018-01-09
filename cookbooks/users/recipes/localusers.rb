group 'superuser' do
  gid 1200
end

node['users'].each do |user|
    u = user['user_attributes']
    username = u['username']
    pub_key = u['pub_key']

    home = "/home/#{username}"

    user "#{username}" do
          shell '/bin/bash'
          home  home
          manage_home true
          gid 1200
    end

    directory "#{home}/.ssh" do
          mode '0700'
          owner "#{username}"
          recursive true
    end

    file "#{home}/.ssh/authorized_keys" do
          mode '0600'
          owner "#{username}"
          content "#{pub_key}"
    end

end

execute 'create sudoer.d file' do
  command 'echo "%superuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/superuser'
  action :run
  not_if { File.exist?("/etc/sudoers.d/superuser") }
end
