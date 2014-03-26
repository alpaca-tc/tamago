module Tamago
  module IO
    autoload :File, 'tamago/io/file'
    autoload :Stdout, 'tamago/io/stdout'
    autoload :Less, 'tamago/io/less'

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

    def self.default_io
      outputter = Tamago.configuration.outputter
      outputter = outputter.to_s.camelcase
      const_get(outputter)
    end
  end
end
