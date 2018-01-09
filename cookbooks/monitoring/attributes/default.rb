# This is a Chef attributes file. It can be used to specify default and override
# attributes to be applied to nodes that run this cookbook.

# Set a default name
#default["starter_name"] = "Sam Doe"

# For further information, see the Chef documentation (https://docs.chef.io/essentials_cookbook_attribute_files.html).
#default['telegraf']['url'] = "http://influxdb-prod.girnarsoft.net:8086"
#default['telegraf']['database'] = "futuredekho1"
#default['telegraf']['address'] = "http://www.futuredekho1.com/"
default['telegraf']['server_name'] = "#{node['ec2']['tags']['Name']}"
