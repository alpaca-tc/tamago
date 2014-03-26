require 'spec_helper'
require 'tamago/io'
require 'tempfile'

module Tamago::IO
  describe File do
    let(:instance) { File.new(temp_path) }
    let(:temp_path) { Tempfile.new('tempfile').tap { |v| v.close }.path }

    before do
      if described_class.instance_variable_defined?(:@file)
        described_class.remove_instance_variable(:@file)
      end
    end

    describe 'ClassMethods' do
      describe '.start' do
        subject { described_class }

        before do
          subject.start
        end

        it 'generates new output file' do
          file = subject.instance_variable_get(:@file)
          expect(file).to be_a_kind_of ::File
        end
      end

      describe '.finish' do
        subject { described_class.finish }

        before do
          described_class.instance_variable_set(:@file, file)
        end

        let(:file) { Tempfile.new('tempfile') }

        it 'closes file' do
          expect(file).to receive(:close).once
          subject
        end
      end
    end
  end
end
