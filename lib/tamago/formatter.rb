require 'tamago/iorable'

module Tamago
  class Formatter
    include IOrable

    autoload :DefaultFormatter, 'tamago/formatter/default_formatter'
    autoload :UniteFormatter, 'tamago/formatter/unite_formatter'
    autoload :JsonFormatter, 'tamago/formatter/json_formatter'

    def initialize(informations, io = nil)
      @informations = informations

      if self.class.ios.empty? && Tamago.configuration.outputter
        self.class.add_io(Tamago.configuration.outputter)
      end
    end

    def start_formatter!
      delegate_to_ios(:start)
      start
    end

    def finish_formatter!
      finish
      delegate_to_ios(:finish)
    end

    def selected_issues(show_type = nil)
      show_type ||= Tamago.configuration.show_type
      @informations.selected_issues(show_type)
    end

    private

    def start
      raise NotImplementedError
    end

    def finish
      raise NotImplementedError
    end
  end
end
