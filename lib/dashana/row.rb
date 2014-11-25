module Dashana
  class Row
    attr_accessor :panels
    def initialize
      @panels = []
    end
    def to_hash
      {"title"=>"test",
        "height"=>"250px",
        "editable"=>true,
        "collapse"=>false,
        "panels"=> @panels.map(&:to_hash)
      }
    end
  end
end
