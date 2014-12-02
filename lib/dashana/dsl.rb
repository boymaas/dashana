module Dashana
  class TargetDsl
    attr_reader :target
    def initialize(&block)
      @target = Target.new
      instance_eval &block
    end

    def series label
      @target.series = label
    end

    def query sql
      @target.query = "#{sql.strip} where $timeFilter group by time($interval) order asc"
    end

    def function type
      @target.function = type
    end
  end

  class PanelDsl
    attr_reader :panel
    def initialize(&block)
      @panel = Panel.new
      instance_eval &block
    end

    def title title
      @panel.title = title
    end

    def span count
      @panel.span = count
    end

    def minimum value
      @panel.minimum = value
    end
    def maximum value
      @panel.maximum = value
    end

    def stacked value
      @panel.stacked = value
    end

    def format *args
      @panel.format = args
    end

    def target &block
      @panel.targets << TargetDsl.new(&block).target
    end

    def overrides value
      @panel.overrides = value
    end

    def fill value
      @panel.fill = value
    end

    def lines
      @panel.lines
    end

    def bars
      @panel.bars
    end
  end

  class RowDsl
    attr_reader :row
    def initialize(&block)
      @row = Row.new
      instance_eval &block
    end

    def panel &block
      @row.panels << PanelDsl.new(&block).panel
    end
  end

  class DashDsl
    attr_reader :dash
    def initialize(&block)
      @dash = Dash.new
      instance_eval &block
    end
    def title title
      @dash.title = title
    end

    def row &block
      @dash.rows << RowDsl.new(&block).row
    end
  end

  module Dsl
    def dashana &block
      @dash_dsl = DashDsl.new(&block).dash
    end
  end

end
