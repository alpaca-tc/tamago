require 'spec_helper'
require 'tamago/file_list_builder'

module Tamago
  describe FileListBuilder do
    describe 'Public Methods' do
      describe '.get_file_list' do
        subject { described_class.get_file_list }

        before do
          expect(Tamago.configuration).to receive(:files).and_return(files)
        end

        let(:files) { [__FILE__] }

        it 'builds array contains file list' do
          should eq files
        end
      end
    end

    describe 'Private Methods' do
      describe '.get_file_list_from_directory' do
        subject { described_class.send(:get_file_list_from_directory, directory) }

        context 'given directory contains no file' do
          before do
            allow(Dir).to receive(:glob).with("#{directory}/**/*").and_return([])
          end

          let(:directory) { '/' }
          it { should eq({}) }
        end

        context 'given directory contains some files' do
          let(:directory) { File.expand_path('../', __FILE__) }
          it { should_not be_empty }
        end
      end

      describe '.ignore_file?' do
        subject { described_class.send(:ignore_file?, file) }

        before do
          allow(described_class).to receive(:ignore_patterns) { ignore_patterns }
        end

        let(:file) { __FILE__ }
        let(:ignore_patterns) { [] }

        context 'given ignore file' do
          let(:ignore_patterns) { [/#{__FILE__}/] }
          it { should be_truthy }
        end

        context 'when argument is not file' do
          let(:file) { File.basename(__FILE__) }
          it { should be_truthy }
        end

        context 'given not ignore file' do
          it { should be_falsy }
        end
      end

      describe '.ignore_patterns' do
        subject { FileListBuilder.send(:ignore_patterns) }

        before do
          allow_any_instance_of(Tamago::Configuration).to receive(:ignore_patterns) { patterns }
        end

        after do
          FileListBuilder.class_eval do |klass|
            klass.remove_instance_variable(:@ignore_patterns)
          end
        end

        context 'when given dot' do
          let(:patterns) { ['.'] }
          it { should eq [/\./] }
        end

        context 'when given asterisk' do
          let(:patterns) { ['*'] }
          it { should eq [/.*/] }
        end
      end
    end
  end
end
