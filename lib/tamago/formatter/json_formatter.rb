require 'tamago/formatter'
require 'json'

module Tamago
  class Formatter::JsonFormatter < Formatter
    def start
      puts selected_issues.to_json
    end

    def finish
    end
  end
end
