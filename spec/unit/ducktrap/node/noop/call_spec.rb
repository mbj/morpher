require 'spec_helper'

describe Ducktrap::Node::Noop, '#call' do
  let(:object) { described_class.instance }

  subject { object.call(input) }

  let(:input) { mock('Input') }

  it { should eql(Ducktrap::Evaluator::Noop.new(object, input)) }
end
