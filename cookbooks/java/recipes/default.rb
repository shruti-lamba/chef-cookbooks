#
# Cookbook:: java
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

bash 'a bash script' do
  user 'root'
  cwd '/opt'
  code <<-EOH
  wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz"
  tar -xzf jdk-8u151-linux-x64.tar.gz
  cd /opt/jdk1.8.0_151/
  alternatives --install /usr/bin/java java /opt/jdk1.8.0_151/bin/java 2
  alternatives --config java
  alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_151/bin/jar 2
  alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_151/bin/javac 2
  alternatives --set jar /opt/jdk1.8.0_151/bin/jar
  alternatives --set javac /opt/jdk1.8.0_151/bin/javac
  export JAVA_HOME=/opt/jdk1.8.0_151
  EOH
  not_if { File.exist?("/bin/java") }
end
