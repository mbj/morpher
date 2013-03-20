require 'spec_helper'

describe Ducktrap::Node::GuardNil, '#run' do
  subject { object.run(input) }

  let(:object)  { described_class.new(operand) }

  let(:operand) { Ducktrap::Node::Noop.instance }

  context 'with nil input' do
    let(:input)       { nil }
    its(:output)      { should be(nil) }
    its(:successful?) { should be(true) }
  end

  context 'with non nil input' do
    let(:input)       { :input           }
    its(:output)      { should be(input) }
    its(:successful?) { should be(true)  }
  end
end
