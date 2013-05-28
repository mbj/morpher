require 'spec_helper'

describe Ducktrap::Node::Static, '#call' do
  let(:object) { described_class.new(value, inverse_value) }

  let(:value)         { mock('Value')         }
  let(:inverse_value) { mock('Inverse Value') }
  let(:input)         { mock('Input')         }

  subject { object.call(input) }

  it { should eql(Ducktrap::Evaluator::Static.new(object, input, value)) }
end
