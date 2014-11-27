require 'pry'

require 'dashana'

@influx_db_saver = Dashana::InfluxDbSaver.new \
    host: ENV['DASH_INFLUX_HOST'],
    username: ENV['DASH_INFLUX_USERNAME'],
    password: ENV['DASH_INFLUX_PASSWORD'],
    database: ENV['DASH_INFLUX_DATABASE'],
    series: ENV['DASH_INFLUX_SERIES']

include Dashana::Dsl

dash = dashana do
  title "Health nodes"

  ["lb",1,2,3,"db","mon"].each do |node_idx|
    row do
      [0,1].each do |cpu_idx|
        panel do
          title "deis-#{node_idx} CPU#{cpu_idx}"
          span 2
          format "percent", "short"
          minimum 0
          maximum 100
          stacked true
          fill 1

          series_prefix = "deis-#{node_idx}.cpu-#{cpu_idx}/cpu-"

          target do
            series series_prefix + "user"
            query <<-sql
             select mean(value) from "#{series_prefix}user"
          sql
          end
          target do
            series series_prefix + "system"
            query <<-sql
             select mean(value) from "#{series_prefix}system"
          sql
          end
        end
      end # end echo cpu

      # Load panel
      panel do
        title "deis-#{node_idx} load"
        span 3
        format "short"
        #maximum 12
        minimum 0
        fill 1

        serie_prefix = "deis-#{node_idx}.load/load"

        %w[shortterm midterm longterm].each do |term|
          target do
            query <<-sql
             select mean(value) from "#{ serie_prefix }/#{term}"
            sql
          end
        end

      end

      # Memory panel
      panel do
        title "deis-#{node_idx} memory"
        span 3
        format "bytes"
        stacked true
        fill 1
        minimum 0

        serie_prefix = "deis-#{node_idx}.memory/memory"

        %w[used free cached].each do |term|
          target do
            query <<-sql
             select mean(value) from "#{ serie_prefix }-#{term}"
            sql
          end
        end
      end

      # Disk panel
      panel do
        title "deis-#{node_idx} disks"
        span 2
        format "bytes"
        stacked true

        serie_prefix = "deis-#{node_idx}.df-root/df_complex"

        %w[used reserved free].each do |term|
          target do
            query <<-sql
             select mean(value) from "#{ serie_prefix }-#{term}"
            sql
          end
        end

        overrides [
                   {
                     alias: "deis-#{node_idx}.df-root/df_complex-used.mean",
                     fill: 2
                   },
                   {
                     alias: "deis-#{node_idx}.df-root/df_complex-reserved.mean",
                     fill: 3
                   }
                  ]
      end

    end
  end
end


@influx_db_saver.save dash
