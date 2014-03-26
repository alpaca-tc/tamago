module Tamago
  module IO
    module Stdout
      include IO

      def self.start
      end
      def self.finish
      end

      def self.p(*args)
        Kernel.p(*args)
      end

      def self.puts(*args)
        Kernel.puts(*args)
      end

      def self.print(*args)
        Kernel.print(*args)
      end
    end
  end
end
