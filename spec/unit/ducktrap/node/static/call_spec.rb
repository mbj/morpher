require 'spec_helper'

describe Ducktrap::Node::Static, '#call' do
  let(:object) { described_class.new(value, inverse_value) }

  let(:value)         { double('Value')         }
  let(:inverse_value) { double('Inverse Value') }
  let(:input)         { double('Input')         }

  subject { object.call(input) }

  it { should eql(Ducktrap::Evaluator::Static.new(object, input, value)) }
end
