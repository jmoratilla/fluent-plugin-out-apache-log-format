require 'fluent/output'

module Fluent
  class ApacheLogFormat < Output
    # First, register the plugin. NAME is the name of this plugin
    # and identifies the plugin in the configuration file.
    Fluent::Plugin.register_output('alf', self)

    # TODO: Add params to allow different field names for the log
    # "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %D"
    # config_param :host, :string
    # config_param :time, :string
    # config_param :method, :string
    # config_param :path, :string
    # config_param :status, :string
    # config_param :size, :integer, :default => 0
    # config_param :referer, :string, :default => ''
    # config_param :user_agent, :string, :default => ''
    # config_param :response_time, :integer, :default => ''

    def configure(conf)
      super
    end

    def initialize
      super
    end

    def start
      super
    end

    def shutdown
      super
    end

    # This method is called when an event reaches Fluentd.
    # 'es' is a Fluent::EventStream object that includes multiple events.
    # You can use 'es.each {|time,record| ... }' to retrieve events.
    # 'chain' is an object that manages transactions. Call 'chain.next' at
    # appropriate points and rollback if it raises an exception.
    #
    # NOTE! This method is called by Fluentd's main thread so you should not write slow routine here. It causes Fluentd's performance degression.
    def emit(tag, es, chain)
      chain.next
      es.each {|time,record|
        puts output_record(record)
      }

    end

    private

    def output_record(record)
      "#{record['ip']} - - [#{DateTime.parse(record['timestamp']).strftime("%d/%b/%Y:%H:%M:%S %z")}] \"#{record['method']} #{record['path'].empty? ? '/' : record['path']}\" #{record['status']} 1024 \"#{record['referer']}\" \"#{record['user_agent']}\" #{record['measuretime']}"
    end
  end
end
