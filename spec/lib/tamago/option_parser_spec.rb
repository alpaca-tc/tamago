require 'spec_helper'
require 'tamago'
require 'tamago/option_parser'

module Tamago
  describe OptionParser do
    subject { option_parser.parse! }

    let(:argv) { [] }
    let(:option_parser) { Tamago::OptionParser.new(argv) }
    let(:stub_exit) { allow(option_parser).to receive(:exit) }
    let(:expect_stdout) do
      capture { subject }
    end

    before do
      if Tamago.instance_variable_defined?(:@configuration)
        Tamago.remove_instance_variable(:@configuration)
      end
    end

    shared_examples_for 'a giving invalid option' do
      it { expect { subject }.to raise_error ::OptionParser::InvalidArgument }
    end

    shared_examples_for 'a parsed option' do |key, expected_value|
      let(:configuration) { Tamago.configuration.send(key) }

      it "set configuration.#{key} to #{expected_value}" do
        subject
        expect(configuration).to eq expected_value
      end
    end

    shared_examples_for 'a missing argument' do |param|
      let(:argv) { [param] }

      context "given #{param}" do
        it 'should be given argument' do
          expect { subject }.to raise_error ::OptionParser::MissingArgument
        end
      end
    end

    describe OptionParser do
      describe '-v --version' do
        let(:argv) { ['--version'] }

        it { expect { subject }.to raise_error SystemExit }

        it 'puts version information' do
          stub_exit
          expect_stdout.to start_with('Tamago v')
        end
      end

      describe '-h --help' do
        let(:argv) { ['--help'] }

        it { expect { subject }.to raise_error SystemExit }

        # it 'puts version information' do
        #   stub_exit
        # end
      end

      describe '--show' do
        it_should_behave_like 'a missing argument', '--show'

        context 'with dirty' do
          let(:argv) { ['--show', 'dirty'] }
          it_should_behave_like 'a parsed option', 'show_type', :dirty
        end

        context 'with all' do
          let(:argv) { ['--show', 'all'] }
          it_should_behave_like 'a parsed option', 'show_type', :all
        end

        context 'with clean' do
          let(:argv) { ['--show', 'clean'] }
          it_should_behave_like 'a parsed option', 'show_type', :clean
        end

        context 'with invalid option' do
          let(:argv) { ['--show', 'invalid_value'] }
          it_should_behave_like 'a giving invalid option'
        end
      end

      describe '--formatter' do
        context 'with json' do
          let(:argv) { ['--formatter', 'json'] }
          it_should_behave_like 'a parsed option', 'formatter', Formatter::JsonFormatter
        end

        context 'with unite' do
          let(:argv) { ['--formatter', 'unite'] }
          it_should_behave_like 'a parsed option', 'formatter', Formatter::UniteFormatter
        end

        context 'with default' do
          let(:argv) { ['--formatter', 'default'] }
          it_should_behave_like 'a parsed option', 'formatter', Formatter::DefaultFormatter
        end

        context 'with invalid option' do
          let(:argv) { ['--formatter', 'invalid_value'] }
          it_should_behave_like 'a giving invalid option'
        end
      end

      describe '--output' do
        context 'with default' do
          let(:argv) { ['--output', '.output_file'] }
          it_should_behave_like 'a parsed option', 'output_file', '.output_file'
        end

        context 'with invalid option' do
          let(:argv) { ['--output', 'invalid_value'] }
          it_should_behave_like 'a missing argument', '--output'
        end
      end

      describe '--ignore' do
        context 'with ignore pattern' do
          let(:argv) { ['--ignore', '.png'] }
          it_should_behave_like 'a parsed option', 'ignore_patterns', %w[.git *.swp .png]
        end

        context 'with invalid option' do
          let(:argv) { ['--output', 'invalid_value'] }
          it_should_behave_like 'a missing argument', '--output'
        end
      end


      # tamag [OPTION] -- file_path file_path ...
      describe '-- files' do
        subject { Tamago.configuration.files }

        before do
          option_parser.parse!
        end

        context 'with no args' do
          it { should eq ['.'] }
        end

        context 'with file path' do
          let(:argv) { ['--', 'file_path', 'file_path2'] }
          it { should eq ['file_path', 'file_path2'] }
        end
      end
    end

    def capture(&block)
      original_stdout = $stdout
      $stdout = fake = StringIO.new

      begin
        yield
      ensure
        $stdout = original_stdout
      end

      expect(fake.string)
    end
  end
end
