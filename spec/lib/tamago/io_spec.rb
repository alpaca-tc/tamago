require 'spec_helper'
require 'tamago'

module Tamago
  describe IO do
    let(:stub_io) do
      Class.new do |k|
        include IO
      end
    end

    describe 'ClassMethods' do
      describe '.build' do
        subject { described_class.build }

        before do
          expect(Tamago.configuration).to receive(:outputter).and_return(outputter)
        end

        let(:outputter) { :file }
        it { should eql IO::File }
      end

      let(:io_instance) { stub_io.new }

      describe '.start' do
        subject { stub_io.start }
        it { expect { subject }.to raise_error NotImplementedError }
      end

      describe '.finish' do
        subject { stub_io.finish }
        it { expect { subject }.to raise_error NotImplementedError }
      end
    end

    describe 'InstanceMethods' do
    end
  end
end
