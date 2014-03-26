module Tamago
  module IO
    autoload :File, 'tamago/io/file'

    def self.included(klass)
      klass.class_eval do |klass|
        extend ClassMethods
      end
    end

    module ClassMethods
      def start
        raise NotImplementedError
      end

      def finish
        raise NotImplementedError
      end
    end

    def self.build
      outputter = Tamago.configuration.outputter
      outputter = outputter.to_s.camelcase
      const_get(outputter)
    end
  end
end
