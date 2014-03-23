require 'tamago/formatter'

module Tamago
  class Formatter::JsonFormatter < Formatter
    def start
      puts selected_issues.to_json
    end
  end
end
