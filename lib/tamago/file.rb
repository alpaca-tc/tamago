module Tamago
  class File < ::File
    def self.dump_result(output)
      path = Tamago.configuration.output_file
      self.open(path, 'w') { |f| f.write(output) }
    end
  end
end
