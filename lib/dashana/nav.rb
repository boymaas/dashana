module Dashana
  class Nav
    def to_hash
      [{"type"=>"timepicker",
         "collapse"=>false,
         "enable"=>true,
         "status"=>"Stable",
         "time_options"=>["5m", "15m", "1h", "6h", "12h", "24h", "2d", "7d", "30d"],
         "refresh_intervals"=>["5s", "10s", "30s", "1m", "5m", "15m", "30m", "1h", "2h", "1d"],
         "now"=>true,
         "notice"=>false}]
    end
  end
end
