require 'spec_helper'

describe Ducktrap::Node::Key::Fetch, '#pretty_inspect' do
  let(:object) { described_class.new(operand, key) }

  let(:operand) { Ducktrap::Node::Static.new(:forward, :inverse) }
  let(:key)     { :key                                           }

  subject { object.pretty_inspect }

  specify do 
    subject.should eql(strip(<<-STR))
      Ducktrap::Node::Key::Fetch
        key: :key
        operand:
          Ducktrap::Node::Static
    STR
  end
end
