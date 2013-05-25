require 'spec_helper'

describe Ducktrap::Error, '#pretty_inspect' do
  let(:object) { described_class.new(context, input) }

  let(:context) { Ducktrap::Node::Noop.instance }
  let(:input)   { :input                        }

  subject { object.pretty_inspect }

  it 'should return inspected error' do
    should eql(strip(<<-STR))
      Ducktrap::Error
        input: :input
        context:
          Ducktrap::Node::Noop
    STR
  end
end
