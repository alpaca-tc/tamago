require 'spec_helper'
require 'tamago'

module Tamago
  describe Formatter do
    let(:formatter) { described_class.new(informations) }
    let(:informations) { Informations.new }

    describe 'ClassMethods' do
      subject { described_class }
      it { should include IOrable }
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

    describe '#start_formatter!' do
      subject { formatter.start_formatter! }

      it 'initializes io' do
        allow_any_instance_of(described_class).to receive(:delegate_to_ios).with(:start)
        expect { subject }.to raise_error(NotImplementedError)
      end
    end

    describe '#finish_formatter!' do
      subject { formatter.finish_formatter! }

      it 'destracts io' do
        allow_any_instance_of(described_class).to receive(:delegate_to_ios).with(:finish)
        expect { subject }.to raise_error(NotImplementedError)
      end
    end

    describe '#start' do
      subject { formatter.send(:start) }
      it { expect { subject }.to raise_error NotImplementedError }
    end

    describe '#finish' do
      subject { formatter.send(:finish) }
      it { expect { subject }.to raise_error NotImplementedError }
    end
  end
end
