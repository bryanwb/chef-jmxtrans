default['jmxtrans']['install_prefix'] = '/opt'
default['jmxtrans']['home'] = "#{node['jmxtrans']['install_prefix']}/jmxtrans"
default['jmxtrans']['log_dir'] = '/var/log/jmxtrans'
default['jmxtrans']['user'] = 'jmxtrans'
default['jmxtrans']['url'] = 'http://jmxtrans.googlecode.com/files/jmxtrans-250.zip'
default['jmxtrans']['checksum'] = 'd6d58b3710046aefaf039d5f921d73ca5b66de2299a572e054a2d70638837e02'
default['jmxtrans']['heap_size'] = '512'
default['jmxtrans']['run_interval'] = '60'
default['jmxtrans']['graphite']['host'] = 'graphite'
default['jmxtrans']['graphite']['port'] = '2003'

default['jmxtrans']['servers'] = []
