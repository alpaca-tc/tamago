module Tamago
  class Formatter
    autoload :DefaultFormatter, 'tamago/formatter/default_formatter'
    autoload :UniteFormatter, 'tamago/formatter/unite_formatter'
    autoload :JsonFormatter, 'tamago/formatter/json_formatter'

    def initialize(informations, io = nil)
      @informations = informations
    end

    def start
      raise NotImplementedError
    end

    def finish
      raise NotImplementedError
    end

    def selected_issues(show_type = nil)
      show_type ||= Tamago.configuration.show_type
      @informations.selected_issues(show_type)
    end
  end
end
