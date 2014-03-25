require 'spec_helper'
require 'tamago/iorable'
require 'tempfile'

module Tamago
  describe IOrable do
    let(:double_class) { Class.new do; end }
    let(:double_instance) { double_class.new }
    let(:described_module) do
      double_class.module_eval do |klass|
        include IOrable
      end
    end

    describe IOrable::ClassMethods do
    end

    context 'Included IOralbe' do
      subject { double_instance }

      shared_examples_for 'a delegating method' do |method|
        before do
          described_module.add_io(string_io)
          described_module.add_io(file_io)
        end

        let(:string_io) { StringIO.new }
        let(:file_io) { Tempfile.new('tempfile') }
        let(:args) { 'output text' }

        it "delegates :#{method} to io" do
          double_instance.ios.each do |io|
            expect(io).to receive(method).once.with(args)
          end

          subject.send(method, args)
        end
      end

      describe '#p' do
        it_should_behave_like 'a delegating method', :p
      end

      describe '#puts' do
        it_should_behave_like 'a delegating method', :puts
      end

      describe '#print' do
        it_should_behave_like 'a delegating method', :print
      end

      describe '#a' do
        it_should_behave_like 'a delegating method', :a
      end
    end
  end
end
