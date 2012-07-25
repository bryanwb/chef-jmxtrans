#
# Cookbook Name:: jmxtrans
# Recipe:: default
#
# Copyright 2012, Bryan W. Berry
#
# Apache 2.0 license
#

include_recipe "logrotate"

if platform_family? "debian"
  init_script_file = "jmxtrans.init.deb.erb"
elsif "rhel"
  init_script_file = "jmxtrans.init.el.erb"
end

user node['jmxtrans']['user']

ark "jmxtrans" do
  url node[:jmxtrans][:url]
  checksum node[:jmxtrans][:checksum]
  version "250"
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

