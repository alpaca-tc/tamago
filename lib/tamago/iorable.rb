module Tamago
  module IOrable
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

    %i[puts print p].each do |method|
      define_method method do |*args|
        ios.each { |io| io.send(method, *args) }
      end
    end
  end
end
