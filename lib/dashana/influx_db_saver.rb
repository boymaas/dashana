require 'influxdb'

module Dashana
  class InfluxDbSaver
    def initialize(opts={})
      @username = opts.fetch :username
      @password = opts.fetch :password
      @database = opts.fetch :database
      @host     = opts.fetch :host
      @port     = opts.fetch :port, 8086
      @series   = opts.fetch :series
    end

    def influxdb
      @influxdb ||= InfluxDB::Client.new @database,
      host: @host,
      username: @username,
      password: @password
    end

    def save dash
      influxdb.write_point(@series, {
                             time: 1000000000,
                             sequence_number: 1,
                             title: dash.title,
                             dashboard: dash.to_hash
                           })
    end
  end
end
