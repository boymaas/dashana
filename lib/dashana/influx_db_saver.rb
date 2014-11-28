require 'influxdb'
require 'base64'

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

    def series_name(slug) 
      ("grafana.dashboard_" + Base64.encode64(slug)).chomp
    end

    def influxdb
      @influxdb ||= InfluxDB::Client.new @database,
      host: @host,
      username: @username,
      password: @password
    end

    def slugifyForUrl  str
        str.downcase.gsub(/[^\w ]+/,'').gsub(/ +/,'-')
    end

    def saved_dashboards
      influxdb.query("list series /grafana/")["list_series_result"].map {|e| e["name"]}
    end

    def drop_all
      saved_dashboards.each do |name|
        puts "dropping #{name}"
        influxdb.query(%Q[drop series "#{name}"])
      end
    end

    def drop dash
      slug = slugifyForUrl(dash.title)
      influxdb.query(%Q[drop series "#{series_name(slug)}"])
    end

    def save dash
      slug = slugifyForUrl(dash.title)
      influxdb.write_point(series_name(slug), {
                             time: 1000000000,
                             sequence_number: 1,
                             title: dash.title,
                             tags: 'dashana',
                             dashboard: dash.to_hash,
                             id: slug
                           })
    end
  end
end
