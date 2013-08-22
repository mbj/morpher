require 'spec_helper'

describe Ducktrap::Node::Invalid, '#call' do
  let(:object) { described_class.instance }

  let(:value)         { double('Value')         }
  let(:inverse_value) { double('Inverse Value') }
  let(:input)         { double('Input')         }

  subject { object.call(input) }

  it { should eql(Ducktrap::Evaluator::Invalid.new(object, input)) }
end
