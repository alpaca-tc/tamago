module Tamago
  module IO
    class Less
      def self.start
        Tamago::IO::File.start
      end

      def self.finish
        Tamago::IO::File.finish
        path = Tamago::IO::File.file.path
        `less -R #{path}`
      end
    end
  end
end
