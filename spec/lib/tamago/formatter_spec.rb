require 'spec_helper'
require 'tamago'

module Tamago
  describe Formatter do
    let(:formatter) { described_class.new(informations) }
    let(:informations) { Informations.new }

    describe '#start' do
      subject { formatter.start }

      it { expect { subject }.to raise_error NotImplementedError }
    end

    describe '#selected_issues' do
      subject { formatter.selected_issues(*args) }

      context 'given :all as show_type' do
        let(:args) { [:all] }

        it 'receives :selected_issues with :all' do
          expect(informations).to receive(:selected_issues).with(*args)
          subject
        end
      end

      context 'given nothing' do
        let(:args) { [] }

        it 'receives :selected_issues with default show_type' do
          show_type = Tamago.configuration.show_type
          expect(informations).to receive(:selected_issues).with(show_type)
          subject
        end
      end
    end
  end
end
