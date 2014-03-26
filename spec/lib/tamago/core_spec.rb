require 'spec_helper'
require 'tamago'

module Tamago
  describe Core do
    describe '.run' do
      subject { Tamago::Core.run([]) }

      before do
        expect(FileListBuilder).to receive(:get_file_list).once.and_return([])
        allow_any_instance_of(Parser).to receive(:parse).with([]).and_return([])
        allow_any_instance_of(Formatter::DefaultFormatter).to receive(:start_formatter!)
        allow_any_instance_of(Formatter::DefaultFormatter).to receive(:finish_formatter!)
        expect(Tamago.configuration).to receive(:formatter).once.and_return(formatter)
        allow_any_instance_of(Parser).to receive(:parse).with([]).and_return([])
      end

      let(:formatter) { Formatter::DefaultFormatter }

      it { expect { subject }.to_not raise_error }
    end
  end
end
