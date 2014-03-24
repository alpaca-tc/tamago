require 'spec_helper'
require 'tamago'

describe Tamago::Core do
  describe '.run' do
    subject { Tamago::Core.run([]) }
    it { subject }
  end
end
