module Tamago::IO
  class File < ::File
    def finish
      self.close
    end
  end
end
