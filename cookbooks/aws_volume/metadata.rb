name       		  "aws_volume"
maintainer 		  "ttn"
maintainer_email  "example@example.com"
license 		  "Apache 2.0"
description 	  "Managing AWS ebs resources"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1.5"
#recipe 			  "aws", "Installs the aws-sdk gem during compile time"

gem 'aws-sdk', '~> 3'
