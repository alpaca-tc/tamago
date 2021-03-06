require 'tamago/formatter'

module Tamago
  class Configuration
    def initialize(attributes = {})
      required_attributes = self.class.required_attributes.dup

      @comment_types     = %w[todo review fix]
      @default_formatter = :default
      @files             = ['.']
      @formatter         = Formatter::DefaultFormatter
      @ignore_patterns   = %w[.git *.swp tmp]
      @in_threads        = 5
      @output_file       = '.tamagoresults'
      @outputter         = :stdout
      @show_type         = :all

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

    add_setting :comment_types
    add_setting :default_formatter
    add_setting :files
    add_setting :formatter
    add_setting :ignore_patterns
    add_setting :in_threads
    add_setting :output_file
    add_setting :outputter
    add_setting :show_type
  end
end
