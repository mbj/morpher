require 'spec_helper'

describe Ducktrap::Unary::InstanceMethods, '#pretty_inspect' do
  let(:object) { Ducktrap::Node::GuardNil.new(Ducktrap::Node::Noop.instance) }

  subject { object.pretty_inspect }

  it 'should inspect correctly' do
    should eql(strip(<<-STR))
      Ducktrap::Node::GuardNil
        operand:
          Ducktrap::Node::Noop
    STR
  end
end
