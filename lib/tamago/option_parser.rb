require 'tamago/version'
require 'optparse'

module Tamago
  class OptionParser
    def initialize(argv)
      @original_argv = argv.dup
      @argv = argv
    end

    def parse!
      option_parser.parse!(@argv)
      Tamago.configuration.files = @argv unless @argv.empty?
    end

    def option_parser
      @option_parser ||= ::OptionParser.new do |parser|
        parser.on("--show SHOW", [:all, :dirty, :clean]) do |show_type|
          Tamago.configuration.show_type = show_type
        end

        parser.on('--formatter FORMATTER', formatters) do |formatter_name|
          name = "#{formatter_name}_formatter".camelcase
          formatter = Formatter.const_get(name)
          Tamago.configuration.formatter = formatter
        end

        parser.on('--file FILE', String) do |file|
          Tamago.configuration.output_file = file
        end

        parser.on('--ignore PATTERN') do |pattern|
          Tamago.configuration.ignore_patterns << pattern
        end

        parser.on('--outputter OUTPUTTER', outputters) do |outputter|
          Tamago.configuration.outputter = outputter
        end

        parser.on_tail('-h', '--help', 'Show this usage message and quit.') do |setting|
          puts parser.help
          exit
        end

        parser.on_tail('-v', '--version', 'Show version information about tamago and quit.') do
          puts "Tamago v#{Version}"
          exit
        end
      end
    end

    private

    def formatters
      @formatters ||= get_constans_symbols(Formatter)
    end

    def outputters
      @outputters ||= get_constans_symbols(IO)
    end

    def get_constans_symbols(module_or_klass)
      module_name = module_or_klass.to_s.sub(/.*::([^:]+)$/, '\1')
      suffix = module_name.underscore
      module_or_klass.constants.map do |v|
        v.to_s.underscore.gsub("_#{suffix}", '').to_sym
      end
    end
  end
end
