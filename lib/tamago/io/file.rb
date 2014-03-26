require 'forwardable'
require 'tamago'

module Tamago
  module IO
    class File
      include IO
      extend Forwardable

      def self.file
        path = Tamago.configuration.output_file
        @file ||= ::File.new(path, 'w')
      end

      def self.start
      end

      def self.finish
        file.close
      end

      def self.puts(*args)
        file.puts(*args)
      end

      def self.p(*args)
        file.p(*args)
      end

      def self.print(*args)
        file.print(*args)
      end
    end
  end
end
