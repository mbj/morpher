require 'spec_helper'

describe Ducktrap::Evaluator, '#output' do
  let(:object) { class_under_test.new(context, input) }

  subject { object.output }

  let(:context) { double('Context') }
  let(:input)   { double('Input') }

  context 'when using nested error' do

    let(:inner) { double('Inner') }

    let(:class_under_test) do
      inner = self.inner
      Class.new(described_class) do
        define_method :process do
          nested_error(inner)
        end
      end
    end

    let(:exception) do
      RuntimeError.new('some-message')
    end

    it { should eql(Ducktrap::Error.new(inner, input)) }

    it_should_behave_like 'an idempotent method'
  end

  context 'when using exception macro' do

    let(:class_under_test) do
      exception = self.exception
      Class.new(described_class) do
        define_method :process do
          exception(exception)
        end
      end
    end

    let(:exception) do
      RuntimeError.new('some-message')
    end

    it { should eql(Ducktrap::Error::Exception.new(context, input, exception)) }

    it_should_behave_like 'an idempotent method'
  end
end
