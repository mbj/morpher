require 'spec_helper'

describe Ducktrap::Node::Anima::Dump, '#pretty_inspect' do
  let(:object) { described_class.new(model) }
  let(:model)  { :model }

  subject { object.pretty_inspect }

  it 'should return inspected error' do
    should eql(strip(<<-STR))
      Ducktrap::Node::Anima::Dump
        model: :model
    STR
  end
end
