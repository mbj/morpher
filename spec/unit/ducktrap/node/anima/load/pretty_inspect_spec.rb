require 'spec_helper'

describe Ducktrap::Node::Anima::Load, '#pretty_inspect' do
  let(:object) { described_class.new(model) }
  let(:model)  { :model }

  subject { object.pretty_inspect }

  it 'should return inspected error' do
    should eql(strip(<<-STR))
      Ducktrap::Node::Anima::Load
        model: :model
    STR
  end
end
