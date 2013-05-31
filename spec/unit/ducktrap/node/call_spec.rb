require 'spec_helper'

describe Ducktrap::Node, '#call' do
  subject { object.call(input) }

  let(:object) { class_under_test.new }
  let(:class_under_test) do
    Class.new(described_class) do
      evaluator = Class.new(Ducktrap::Evaluator) do
        def output
          :foo
        end
      end
      const_set(:Evaluator, evaluator)
    end
  end

  let(:input) { mock('Input') }

  it { should eql(class_under_test::Evaluator.new(object, input)) }
end
