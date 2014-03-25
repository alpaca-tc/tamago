require 'active_support/core_ext/string'
require 'tamago/configuration'
require 'tamago/core'
require 'tamago/file_list_builder'
require 'tamago/formatter'
require 'tamago/informations'
require 'tamago/io'
require 'tamago/iorable'
require 'tamago/issues'
require 'tamago/option_parser'
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
