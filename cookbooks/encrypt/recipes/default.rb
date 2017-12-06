
enc_key = ''
key_name = 'secret_key'
log 'Copying enc databag key at node'
execute 'download key' do
  command 'https://s3.ap-south-1.amazonaws.com/girnarsoft-installs/secret_file /etc/chef/secret_key'
  action :run
  not_if { File.exist?("/etc/chef/secret_key") }
  notifies :run, 'bash[add entry to client.rb]'
end
bash 'add entry to client.rb' do
  user 'root'
  code <<-EOH
  echo 'encrypted_data_bag_secret "/etc/chef/secret_key"'
  EOH
  action :nothing
end