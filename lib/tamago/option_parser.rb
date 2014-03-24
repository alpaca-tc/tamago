require 'tamago/version'

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
          name = string2camel_case("#{formatter_name}_formatter")
          formatter = Formatter.const_get(name)
          Tamago.configuration.formatter = formatter
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
      @formatters ||= Formatter.constants.map do |v|
        string2underscore(v.to_s).gsub('_formatter', '').to_sym
      end
    end

    def string2underscore(camel_cased_word)
      camel_cased_word = camel_cased_word.to_s
      camel_cased_word.gsub(/::/, '/')
        .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
        .gsub(/([a-z\d])([A-Z])/,'\1_\2')
        .tr('-', '_')
        .downcase
    end

    def string2camel_case(underscore)
      underscore = underscore.to_s
      if underscore !~ /_/ && underscore =~ /[A-Z]+.*/
        return underscore
      end

      underscore.split('_').map{ |e| e.capitalize }.join
    end
  end
end
