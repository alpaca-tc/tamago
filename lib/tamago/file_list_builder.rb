require 'tamago'

module Tamago
  module FileListBuilder
    class << self
      def get_file_list
        Tamago.configuration.directories.each_with_object({}) { |dir, memo|
          Dir.glob("#{dir}/**/*").each do |f|
            next if ignore_file?(f)
            memo[f] = nil
          end
        }.keys
      end

      def ignore_file?(file)
        return true unless File.file?(file)
        ignore_patterns.any? { |v| v =~ file }
      end

      private

      def ignore_patterns
        @ignore_patterns ||= begin
          patterns = Tamago.configuration.ignore_patterns
          patterns.each_with_object([]) do |pattern, memo|
            pattern = pattern.gsub('.', '\.').gsub('*', '.*')
            memo << Regexp.new(pattern)
          end
        end
      end
    end
  end
end
