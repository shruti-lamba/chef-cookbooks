
enc_key = ''
key_name = 'secret_key'
log 'Copying enc databag key at node'
enc_key = data_bag_item('chef_credentials', 'encryption_key')['key']
file "/etc/chef/#{key_name}" do
  content enc_key
  sensitive true
  owner 'root'
  group 'root'
  mode '0600'
  action :create
  notifies :run, 'bash[add entry to client.rb]'
  not_if { File.exist?("/etc/chef/#{key_name}") }
end
bash 'add entry to client.rb' do
  user 'root'
  code <<-EOH
  echo 'encrypted_data_bag_secret "/etc/chef/#{key_name}"'
  EOH
  action :nothing
end
