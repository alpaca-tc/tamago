require 'spec_helper'
require 'tamago'

module Tamago
  describe IO do
    describe '.build' do
      before do
        expect(Tamago.configuration).to receive(:outputter).and_return(outputter)
      end

      describe '.build' do
        subject { described_class.build }
        let(:outputter) { :file }
        it { should eql IO::File }
      end
    end
  end
end
