default['jmxtrans']['install_prefix'] = '/opt'
default['jmxtrans']['home'] = "#{node['jmxtrans']['install_prefix']}/jmxtrans"
default['jmxtrans']['user'] = 'jmxtrans'
default['jmxtrans']['url'] = ''
default['jmxtrans']['checksum'] = ''
default['jmxtrans']['heap_size'] = '512'
default['jmxtrans']['run_interval'] = '60'
default['jmxtrans']['graphite']['host'] = 'graphite'
default['jmxtrans']['graphite']['port'] = '2003'

default['jmxtrans']['servers'] = []
