require 'spec_helper'

describe Ducktrap::Node, '#call' do
  subject { object.call(input) }

  let(:object) { class_under_test.new }

  let(:class_under_test) do
    result = self.result
    Class.new(described_class) do
      define_method :run do |input|
        result
      end
    end
  end

  class Result
    attr_reader :output

    def initialize(output, successful)
      @output, @successful = output, successful
    end

    def assert_successful
      raise unless @successful
    end
  end

  let(:result) { Result.new(output, successful?) }
  let(:input)  { mock('Input') }
  let(:output) { mock('Output') }

  context 'when result is successful' do
    let(:successful?) { true }

    it { should be(output) }
  end

  context 'when result is NOT successful' do
    let(:successful?) { false }

    it 'should raise error' do
      expect { subject }.to raise_error
    end
  end
end
