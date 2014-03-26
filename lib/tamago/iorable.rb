module Tamago
  module IOrable
    PRINT_METHODS = %i[puts print p].freeze

    def self.included(klass)
      super

      klass.class_eval do |klass|
        extend ClassMethods
      end
    end

    module ClassMethods
      def add_io(io)
        ios << io
      end

      def io=(io)
        @ios = [io]
      end

      def ios
        @ios ||= []
      end
    end

    def ios
      self.class.ios
    end

    private

    PRINT_METHODS.each do |method|
      define_method method do |*args|
        delegate_to_ios(method, *args)
        nil
      end
    end

    def delegate_to_ios(method, *args)
      ios.each { |io| io.send(method, *args) }
    end
  end
end
