require 'spec_helper'
require 'tamago'

module Tamago
  describe Parser do
    let(:instance) { described_class.new }

    describe '.new' do
      subject { instance }
      it { should be_a_kind_of described_class }
    end

    # [todo] - 設定ファイルを抽象的にあつかう処理
    describe '#parse' do
      let(:file_list) { ['', ''] }

      it 'calls #parse_file length of arguments times' do
        expect_any_instance_of(described_class).to receive(:parse_file).twice
        instance.parse(file_list)
      end
    end

    describe '#parse_file' do
      subject { instance.parse_file(file) }

      let(:file) { File.expand_path('../../../assets/testfile.rb', __FILE__) }

      it 'parses file' do
        expect(subject[:issues].length).to eql 2
      end
    end
  end
end
