module Tamago
  module Core
    class << self
      def run(argv)
        OptionParser.new(argv).parse!

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
