default['jmxtrans']['install_prefix'] = '/opt'
default['jmxtrans']['home'] = "#{node['jmxtrans']['install_prefix']}/jmxtrans"
default['jmxtrans']['log_dir'] = '/var/log/jmxtrans'
default['jmxtrans']['user'] = 'jmxtrans'
default['jmxtrans']['url'] = 'https://github.com/downloads/lookfirst/jmxtrans/jmxtrans-20120525-210643-4e956b1144.zip'
default['jmxtrans']['checksum'] = '0a5a2c361cc666f5a7174e2c77809e1a973c3af62868d407c68beb892f1b0217'
default['jmxtrans']['heap_size'] = '512'
default['jmxtrans']['run_interval'] = '60'
default['jmxtrans']['graphite']['host'] = 'graphite'
default['jmxtrans']['graphite']['port'] = '2003'

default['jmxtrans']['servers'] = []
