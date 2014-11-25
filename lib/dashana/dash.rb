module Dashana
  class Dash
    attr_accessor :title, :rows
    def initialize
      @rows = []
      @nav = Nav.new
      @title = "Health Nodes"
    end

    def to_hash
      {"id"=>nil,
        "title"=>@title,
        "originalTitle"=>@title,
        "tags"=>[],
        "style"=>"dark",
        "timezone"=>"browser",
        "editable"=>true,
        "hideControls"=>false,
        "rows"=> @rows.map(&:to_hash),
        "time"=>{"from"=>"now-15m", "to"=>"now"},
        "templating"=>{"list"=>[]},
        "annotations"=>{"list"=>[], "enable"=>false},
        "nav" => @nav.to_hash,
        "refresh"=>false,
        "version"=>6}
    end

    def to_json
      to_hash.to_json
    end

  end
end
