require 'forwardable'
require 'tamago'

module Tamago
  module IO
    class File
      include IO
      extend Forwardable

      def self.start
        path = Tamago.configuration.output_file
        @file = ::File.new(path, 'w')
      end

      def self.finish
        @file.close
      end

      def_delegators :@file, *Tamago::IOrable::PRINT_METHODS
    end
  end
end
