require 'spec_helper'
require 'tamago'

describe Tamago do
  describe '.configuration' do
    subject { described_class.configuration }
    it { should be_a_kind_of Tamago::Configuration }
  end

  describe '.configure' do
    it { expect { |b| described_class.configure(&b) }.to yield_control.once }
  end
end
