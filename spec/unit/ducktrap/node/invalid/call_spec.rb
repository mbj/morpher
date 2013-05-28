require 'spec_helper'

describe Ducktrap::Node::Invalid, '#call' do
  let(:object) { described_class.instance }

  let(:value)         { mock('Value')         }
  let(:inverse_value) { mock('Inverse Value') }
  let(:input)         { mock('Input')         }

  subject { object.call(input) }

  it { should eql(Ducktrap::Evaluator::Invalid.new(object, input)) }
end
