require 'spec_helper'
require 'tamago/version'

module Tamago
  describe 'VERSION' do
    subject { Tamago::VERSION }

    it { should match /\d+\.\d+\.\d+/ }

    it 'aliases to Version' do
      should eql Tamago::Version
    end
  end
end
