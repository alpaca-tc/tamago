module Tamago
  module Core
    def self.run(argv)
      OptionParser.new(argv).parse!

      # [todo] - Read configuration file
      file_list = FileListBuilder.get_file_list
      issues = Parser.new.parse(file_list)
      formatter = Tamago.configuration.formatter.new(issues)
      formatter.start_formatter!
      formatter.finish_formatter!
    end
  end
end
