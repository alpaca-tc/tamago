require 'tamago/formatter'

module Tamago
  class Configuration
    def initialize(attributes = {})
      required_attributes = self.class.required_attributes.dup

      @default_formatter = :default
      @comment_types = %w[todo review fix]
      @ignore_patterns = %w[.git *.swp]
      @directories = %w[.]
      @formatter = Formatter::DefaultFormatter
      @show_type = :all
      @in_threads = 5
      @output_file = '.tamagoresults'
      @files = ['./']

      attributes.each do |key, value|
        required_attributes.delete(key)
        send("#{key}=", value)
      end

      unless required_attributes.empty?
        keys = required_attributes.keys.map { |v| ":#{v}" }.join(', ')
        raise ArgumentError, "Unable to initialize #{keys} without attribute"
      end
    end

    class << self
      def add_setting(name, opts={})
        attr_accessor name

        define_predicating_for(name) if opts.delete(:predicate)
        define_required_attribute(name) if opts.delete(:required)
      end

      def required_attributes
        @required_attributes ||= {}
      end

      private

      def define_required_attribute(*names)
        names.each do |name|
          required_attributes[name] = nil
        end
      end

      def define_predicating_for(*names)
        names.each do |name|
          define_method "#{name}?" do
            !!send(name)
          end
        end
      end
    end

    add_setting :default_formatter
    add_setting :comment_types
    add_setting :ignore_patterns
    add_setting :directories
    add_setting :formatter
    add_setting :show_type
    add_setting :in_threads
    add_setting :output_file
    add_setting :files
  end
end
