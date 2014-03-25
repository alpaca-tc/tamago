require 'spec_helper'
require 'tamago/io'
require 'tempfile'

module Tamago::IO
  describe File do
    let(:instance) { File.new(tempfile.path) }
    let(:tempfile) { Tempfile.new('tempfile') }

    before do
      tempfile.close
    end

    describe '#finish' do
      subject { instance.finish }

      it 'closes file' do
        expect(instance).to receive(:close).once
        subject
      end
    end
  end
end
