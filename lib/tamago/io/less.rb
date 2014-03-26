module Tamago
  module IO
    class Less
      def self.start
        Tamago::IO::File.start
      end

      def self.finish
        Tamago::IO::File.finish
        file = Tamago::IO::File.file
        system("less -R #{file.path}")
        ::File.delete(file.path)
      end

      def self.puts(*args)
        Tamago::IO::File.puts(*args)
      end

      def self.print(*args)
        Tamago::IO::File.print(*args)
      end

      def self.p(*args)
        Tamago::IO::File.p(*args)
      end
    end
  end
end
