require 'spec_helper'

describe Ducktrap::Node, '#run' do
  subject { object.run(input) }

  let(:object) { class_under_test.new }

  let(:class_under_test) do
    evaluator = self.evaluator
    Class.new(described_class) do
      define_method :call do |input|
        evaluator
      end
    end
  end

  class Evaluator
    attr_reader :output

    def initialize(output, successful)
      @output, @successful = output, successful
    end

    def assert_successful
      raise unless @successful
    end
  end

  let(:evaluator) { Evaluator.new(output, successful?) }
  let(:input)  { double('Input') }
  let(:output) { double('Output') }

  context 'when evaluator is successful' do
    let(:successful?) { true }

    it { should be(output) }
  end

  context 'when evaluator is NOT successful' do
    let(:successful?) { false }

    it 'should raise error' do
      expect { subject }.to raise_error
    end
  end
end
