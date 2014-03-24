require 'tamago/core'
require 'tamago/option_parser'
require 'tamago/file_list_builder'
require 'tamago/formatter'
require 'tamago/configuration'
require 'tamago/parser'

module Tamago
  autoload :File, 'tamago/file'

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(self.configuration)
  end
end
