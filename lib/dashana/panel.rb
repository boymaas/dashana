module Dashana
  class Panel
    attr_accessor :targets, :span, :format, :maximum, :minimum, :title
    @@panel_idx = 0
    def initialize
      @targets = []
      @panel_idx = ( @@panel_idx += 1 )
      @span = 4
      @format = ["percent", "short"]
      @maximum = nil
      @minimum = nil
      @title = "New panel #{@panel_idx}"
    end
    def to_hash
      {"id"=>@@panel_idx,
        "span"=>@span,
        "type"=>"graph",
        "x-axis"=>true,
        "y-axis"=>true,
        "scale"=>1,
        "y_formats"=> @format,
        "grid"=>
        {"max"=>nil, "min"=>nil, "leftMax"=>@maximum, "rightMax"=>nil, "leftMin"=>@minimum, "rightMin"=>nil, "threshold1"=>nil, "threshold2"=>nil, "threshold1Color"=>"rgba(216, 200, 27, 0.27)", "threshold2Color"=>"rgba(234, 112, 112, 0.22)"},
        "resolution"=>100,
        "lines"=>true,
        "fill"=>1,
        "linewidth"=>2,
        "points"=>false,
        "pointradius"=>5,
        "bars"=>false,
        "stack"=>true,
        "spyable"=>true,
        "options"=>false,
        "legend"=>{"show"=>true, "values"=>false, "min"=>false, "max"=>false, "current"=>false, "total"=>false, "avg"=>false},
        "interactive"=>true,
        "legend_counts"=>true,
        "timezone"=>"browser",
        "percentage"=>false,
        "zerofill"=>true,
        "nullPointMode"=>"connected",
        "steppedLine"=>false,
        "tooltip"=>{"value_type"=>"individual", "query_as_alias"=>true},
        "targets" => @targets.map(&:to_hash),
        "aliasColors"=>{},
        "aliasYAxis"=>{},
        "title"=>@title,
        "datasource"=>"influxdb",
        "renderer"=>"flot",
        "annotate"=>{"enable"=>false},
        "seriesOverrides"=>[],
        "leftYAxisLabel"=>""}
    end
  end
end
