require 'spec_helper'

describe Ducktrap::Node::Primitive, '#pretty_inspect' do
  let(:object)    { described_class.new(primitive) }
  let(:primitive) { String }

  subject { object.pretty_inspect }

  it 'should return inspected error' do
    should eql(strip(<<-STR))
      Ducktrap::Node::Primitive
        primitive: String
    STR
  end
end
