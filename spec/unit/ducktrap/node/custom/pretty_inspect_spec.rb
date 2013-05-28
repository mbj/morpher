require 'spec_helper'

describe Ducktrap::Node::Custom, '#pretty_inspect' do
  let(:object)    { described_class.new(:forward, :inverse) }

  subject { object.pretty_inspect }

  it 'should return inspected error' do
    should eql(strip(<<-STR))
      Ducktrap::Node::Custom
        forward: :forward
        inverse: :inverse
    STR
  end
end
