require 'tamago/core'
require 'tamago/file_list_builder'
require 'tamago/configuration'
require 'tamago/parser'

module Tamago
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(self.configuration)
  end
end
