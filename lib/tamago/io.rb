module Tamago
  module IO
    autoload :File, 'tamago/io/file'

    def self.build
      outputter = Tamago.configuration.outputter
      outputter = outputter.to_s.camelcase
      const_get(outputter)
    end
  end
end
