require 'spec_helper'
require 'tamago'
require 'tamago/formatter/default_formatter'

module Tamago
  describe Formatter::DefaultFormatter do
    let(:instance) { Formatter::DefaultFormatter.new(issues) }
    let(:issues) do
      Issues.new
    end

    describe '.start' do
      subject { instance.start }
      it { should_not raise_error }
    end
  end
end
