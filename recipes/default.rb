#
# Cookbook Name:: jmxtrans
# Recipe:: default
#
# Copyright 2012, Bryan W. Berry
#
# Apache 2.0 license
#

include_recipe "logrotate"

if platform_family?("debian")
  init_script_file = "jmxtrans.init.deb.erb"
elsif platform_family?("rhel")
  init_script_file = "jmxtrans.init.el.erb"
end

user node['jmxtrans']['user']

# merge stock jvm queries w/ container specific ones into single array
servers = node['jmxtrans']['servers']
servers.each do |server|
  server['queries'] = node['jmxtrans']['default_queries']['jvm']
  case server['type']
  when 'tomcat'
    server['queries'] << node['jmxtrans']['default_queries']['tomcat']
  end
  server['queries'].flatten!
end

ark "jmxtrans" do
  url node['jmxtrans']['url']
  checksum node['jmxtrans']['checksum']
  version "latest"
  prefix_root '/opt'
  prefix_home '/opt'
  owner node['jmxtrans']['user']
  group node['jmxtrans']['user']
end

template "/etc/init.d/jmxtrans" do
  source init_script_file
  owner "root"
  group "root"
  mode  "0755"
  variables( :name => 'jmxtrans' )
  notifies :restart, "service[jmxtrans]"
end

template "/etc/default/jmxtrans" do
  source "jmxtrans_default.erb"
  owner "root"
  group "root"
  mode  "0644"
  notifies :restart, "service[jmxtrans]"
end

directory node['jmxtrans']['log_dir'] do
  owner node['jmxtrans']['user']
  group node['jmxtrans']['user']
  mode  "0755"
end

directory "#{node['jmxtrans']['home']}/json" do
  owner node['jmxtrans']['user']
  group node['jmxtrans']['user']
  mode  "0755"
end

template "#{node['jmxtrans']['home']}/json/set1.json" do
  source "set1.json.erb"
  owner node['jmxtrans']['user']
  group node['jmxtrans']['user']
  mode  "0755"
  notifies :restart, "service[jmxtrans]"
  variables(
            :servers => servers,
            :graphite_host => node['jmxtrans']['graphite']['host'],
            :graphite_port => node['jmxtrans']['graphite']['port'],
            :root_prefix => node['jmxtrans']['root_prefix']
            )
end


logrotate_app "jmxtrans" do
  cookbook "logrotate"
  path "#{node['jmxtrans']['log_dir']}/*.log"
  frequency "daily"
  rotate 7
  create "644 #{node['jmxtrans']['user']} #{node['jmxtrans']['user']} "
end

# the init script uses this command
link "/usr/bin/jps"  do
  to "#{node['java']['java_home']}/bin/jps"
end

service "jmxtrans" do
  supports :restart => true, :status => true, :reload => true
  action [ :enable, :start]
end

