require 'tamago'
require 'parallel'

module Tamago
  module FileListBuilder
    class << self
      def get_file_list
        Tamago.configuration.files.each_with_object({}) { |path, files|
          if File.file?(path)
            files[path] = nil
          else
            files.merge!(get_file_list_from_directory(path))
          end
        }.keys
      end

      private

      def get_file_list_from_directory(directory)
        files = {}
        paths = Dir.glob("#{directory}/**/*")

        in_threads = Tamago.configuration.in_threads
        Parallel.each(paths, in_threads: in_threads) do |f|
          next if ignore_file?(f)
          files[f] = nil
        end

        files
      end

      def ignore_file?(file)
        return true unless File.file?(file)
        ignore_patterns.any? { |v| v =~ file }
      end

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
