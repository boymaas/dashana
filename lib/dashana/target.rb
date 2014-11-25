module Dashana
  class Target
    attr_accessor :series, :query, :function
    def initialize
      @function = 'mean'
      @column = 'value'
      @series = ""
      @query = ""
    end

    def to_hash
      {"target"=>"randomWalk('random walk')",
        "function"=>"mean",
        "column"=>"value",
        "series"=>@series,
        "query"=> @query,
        "rawQuery"=>true}
    end
  end
end
