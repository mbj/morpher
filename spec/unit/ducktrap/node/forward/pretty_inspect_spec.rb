require 'spec_helper'

describe Ducktrap::Node::Forward, '#pretty_inspect' do
  let(:object)    { described_class.new(operand) }
  let(:primitive) { String }

  let(:operand) { Ducktrap::Node::Noop.instance }
  let(:key)     { :key                          }

  subject { object.pretty_inspect }

  it 'should return inspected error' do
    should eql(strip(<<-STR))
      Ducktrap::Node::Forward
        operand:
          Ducktrap::Node::Noop
    STR
  end
end
