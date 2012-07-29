# <a name="title"></a> chef-jmxtrans[![Build Status](https://secure.travis-ci.org/bryanwb/chef-jmxtrans.png?branch=master)](http://travis-ci.org/bryanwb/chef-jmxtrans)


Description
===========

I am the jmxtrans cookbook!

[jmxtrans](https://github.com/lookfirst/jmxtrans) is an excellent tool
for transporting jmx data from your VMs and into a graphing tool like
graphite or ganglia. This cookbook only supports writing to graphite
but could be easily modified to work with ganglia


Requirements
============

Depends on the ark cookbook


Attributes
==========

* `node['jmxtrans']['graphite']['host']` - defaults to 'graphite'
* `node['jmxtrans']['graphite']['port']` - default to 2003
* `node['jmxtrans']['servers']` - array of servers to query for jmx data
  along with the properties needed to access each one
* `node['jmxtrans']['root_prefix']` - root prefix for the graphite
  buckets, defaults to "jmx"
  

Usage
=====

You must override the attribute `node['jmxtrans']['servers']` with the
list of servers you want monitored and their respective properties

the following example comes from a role

```
:jmxtrans => {
   :servers =>[
      {
        'name' => 'foo1.example.org',
        'port' => "8999",
        'type' => 'tomcat',
        'username' => 'foobar',
        'password' => 'rw'
      },
      {
        'name' => 'foo2.example.org',
        'port' => "8999",
        'type' => 'tomcat',
        'username' => 'foobar',
        'password' => 'baz'
       }
     ]                                   
}
```

Author
======

Bryan W. Berry, Copyright 2012, Apache 2.0 license
