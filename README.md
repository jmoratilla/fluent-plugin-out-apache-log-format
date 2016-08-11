# Fluentd output plugin from custom log format to Apache Common Combined Log Format.

This is a quick and dirty try on creating an output filter for Fluentd (http://fluentd.org).

This plugin doesn't work alone.  You need to install and configure the fluentd data collector.


## Installation

First, create an empty bundle project:

    $ bundle init

Add these lines to your application's Gemfile:

```ruby
gem 'fluentd'
gem 'fluent-plugin-out_apache_log_format'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-out_apache_log_format

## Usage

This is an output plugin for Fluentd.  You need a fluentd config file to make it works.

```
# fluent conversor: from our custom log format to apache common combined log format 
<source>
  @type tail
  format /\A(?<logid>(\d+) <(\d+)>(\d+)) (?<timestamp>\S+) app (?<host>\S+) - - \[REQUEST\] request_id='(?<request_id>.*?)' action='(?<action>.*?)' format='(?<format>.*?)' method='(?<method>.*?)' path='(?<path>.*?)' user_agent='(?<user_agent>.*?)' ip='(?<proxy_ip>.*?)' xff_ip='(?<ip_chain>.*?)' referer='(?<referer>.*?)' scheme='(?<scheme>.*?)' status='(?<status>.*?)' measuretime='(?<measuretime>.*?)'\z/
  path inputfile
  pos_file inputfile.pos
  tag get_remote_host
</source>

# This filter helps to get the real source ip address from the connection.
<filter get_remote_host>
  @type record_transformer
  enable_ruby true
  <record>
    ip ${ip_chain.split(',')[0]}
  </record>
</filter>

# This output config will send everything to stdout
<match *>
  @type alf
</match>

```

Now you can execute the following command:


    $ fluentd -c fluentd.conf



And send logs to the inputfile with:
 

    $ cat logfile >> inputfile

They will be filtered, parsed and converted to Apache Log Format.

If you want to generate a file, then append a tee command to the fluentd command, like:

    $ fluentd -qqc fluentd.conf | tee outputfile

