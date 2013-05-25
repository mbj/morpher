require 'spec_helper'

describe Ducktrap::Node::Static, '#run' do
  let(:object) { described_class.new(value, inverse_value) }

  let(:value)         { mock('Value')         }
  let(:inverse_value) { mock('Inverse Value') }
  let(:input)         { mock('Input')         }

  subject { object.run(input) }

  it { should eql(Ducktrap::Evaluator::Static.new(object, input, value)) }
end
