default['jmxtrans']['install_prefix'] = '/opt'
default['jmxtrans']['home'] = "#{default['jmxtrans']['install_prefix']}/jmxtrans"
default['jmxtrans']['log_dir'] = '/var/log/jmxtrans'
default['jmxtrans']['user'] = 'jmxtrans'
default['jmxtrans']['url'] = 'https://github.com/downloads/jmxtrans/jmxtrans/jmxtrans-20120525-210643-4e956b1144.zip'
default['jmxtrans']['checksum'] = '0a5a2c361cc666f5a7174e2c77809e1a973c3af62868d407c68beb892f1b0217'
default['jmxtrans']['heap_size'] = '512'
default['jmxtrans']['run_interval'] = '60'
default['jmxtrans']['log_level'] = 'debug'
default['jmxtrans']['graphite']['host'] = 'graphite'
default['jmxtrans']['graphite']['port'] = '2003'

default['jmxtrans']['servers'] = []
#
# Example servers attribute set-up
#
#default['jmxtrans']['servers'] = [
#	{ "name" => "10.0.100.14",
#	  "port" => "9999",
#	  "type" => "kafka"
#	  "usermame" => "xxxx",
#	  "password" => "yyyy"
#	}],
#	{ "name" => "10.0.100.14",
#	  "port" => "9999",
#	  "type" => "tomcat",
#	  "usermame" => "xxxx",
#	  "password" => "yyyy"
#	}
#]
default['jmxtrans']['root_prefix'] = "jmx"
default['jmxtrans']['default_queries'] = {
  'jvm' => [
            {
              "result_alias" => "memory",
              "obj" => "java.lang:type=Memory",
              "attr" => [ "HeapMemoryUsage", "NonHeapMemoryUsage" ]
            },
            {
              "result_alias" => "memorypool",
              "obj" => "java.lang:type=MemoryPool,name=*",
              "attr" => [ "Usage" ]
            },
            {
              "result_alias" => "gc",
              "obj" => "java.lang:type=GarbageCollector,name=*",
              "attr" => [ "CollectionCount", "CollectionTime" ]
            },
            {
            "result_alias" => "threads",
            "obj" => "java.lang:type=Threading",
            "attr" => [
                       "DaemonThreadCount",
                       "PeakThreadCount",
                       "ThreadCount",
                       "TotalStartedThreadCount"
                      ]
            }
           ],
  'tomcat' => [
               {
                 'obj' => "Catalina:type=ThreadPool,name=*",
                 'result_alias' => "connectors",
                 'attr' => [ "currentThreadCount", "currentThreadsBusy", "" ]
               },
               {
                 'obj' => "Catalina:type=GlobalRequestProcessor,name=*",
                 'result_alias' => "requests",
                 'attr' => [ "bytesReceived", "bytesSent", "errorCount", "maxTime", "processingTime", "requestCount" ]
               },
               {  "obj" => "Catalina:type=DataSource,class=javax.sql.DataSource,name=*",
                 "result_alias" => "datasources",
                 "attr" => [ "NumActive", "NumIdle", "NumQueryThreads" ]
               }
              ],
  'kafka' => [
	      {
		'obj' => "\\\"kafka.server\\\":type=\\\"BrokerTopicMetrics\\\",name=*",
		'result_alias' => "kafka.BrokerTopicMetrics",
		'attr' => [ "Count", "MeanRate", "OneMinuteRate", "FiveMinuteRate", "FifteenMinuteRate" ]
	      }
             ]
}
