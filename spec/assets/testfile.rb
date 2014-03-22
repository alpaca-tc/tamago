require 'spec_helper'
require 'tamago'

module Tamago
  describe Parser do
    let(:args) { [] }
    let(:instance) { described_class.new(args) }
    # [todo] - 8.Todo comment

    describe '.new' do
      # [review] - 11.Review comment
      subject { described_class.new([]) }
      it { should be_a_kind_of described_class }
    end

    describe '#parse' do
    end

    describe '#parse_file' do
      subject { instance.parse_file(file_name) }

      it 'parses file' do

      end
    end
  end
end
