require 'spec_helper'
require 'tamago'
require 'tamago/issues'

module Tamago
  describe Issues do
    it { should be_a_kind_of Hash }

    describe 'InstanceMethods' do
      let(:instance) { Issues.new }

      describe '#build_file_information' do
        context 'when given a path' do
          subject { instance.build_file_information(path) }
          let(:path) { 'path' }

          it { should be_a_kind_of Hash }
        end
      end
    end
  end
end
