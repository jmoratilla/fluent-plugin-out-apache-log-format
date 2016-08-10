require 'fluent/output'

module Fluent
  class ApacheLogFormat < Output
    # First, register the plugin. NAME is the name of this plugin
    # and identifies the plugin in the configuration file.
    Fluent::Plugin.register_output('alf', self)


    # This method is called when an event reaches Fluentd.
    # 'es' is a Fluent::EventStream object that includes multiple events.
    # You can use 'es.each {|time,record| ... }' to retrieve events.
    # 'chain' is an object that manages transactions. Call 'chain.next' at
    # appropriate points and rollback if it raises an exception.
    #
    # NOTE! This method is called by Fluentd's main thread so you should not write slow routine here. It causes Fluentd's performance degression.
    def emit(tag, es, chain)
      es.each {|time,record|
        Engine.emit(format_record(record))
      }
      chain.next
    end

    private

    def format_record(record)
      "#{record['ip']} - - [#{record['timestamp']}] \"#{record['http_method']} #{record['http_path']}\" #{record['status']} #{record['measuretime']} \"#{record['referer']}\" \"#{record['user_agent']}\""
    end
  end
end