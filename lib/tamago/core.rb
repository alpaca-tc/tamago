module Tamago
  module Core
    class << self
      def run
        # [todo] - Option parse
        # [todo] - Read configuration file
        file_list = FileListBuilder.get_file_list
        parser = Parser.new
        issues = parser.parse(file_list)
        formatter = Tamago.configuration.formatter.new(issues)
        formatter.start
      end
    end
  end
end
