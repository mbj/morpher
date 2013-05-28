require 'spec_helper'

describe Ducktrap::Node::Inverse, '#call' do
  let(:object)  { described_class.new(operand)    }
  let(:operand) { Ducktrap::Node::Noop.instance   }
  let(:input)   { mock('Input', :frozen? => true) }

  subject { object.call(input) }

  it { should eql(Ducktrap::Evaluator::Noop.new(object, input)) }
end
