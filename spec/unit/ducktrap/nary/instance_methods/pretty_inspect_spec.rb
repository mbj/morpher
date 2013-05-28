require 'spec_helper'

describe Ducktrap::Nary::InstanceMethods, '#pretty_inspect' do
  let(:object)    { class_under_test.new(body) }

  let(:class_under_test) do
    Class.new(Ducktrap::Node) do
      include Ducktrap::Nary

      def self.name
        'Test'
      end
    end
  end

  let(:body) { [node_a, node_b] }

  let(:node_a) { Ducktrap::Node::Static.new(:a, :b) }
  let(:node_b) { Ducktrap::Node::Noop.instance      }

  subject { object.pretty_inspect }

  it 'should return inspected error' do
    should eql(strip(<<-STR))
      Test
        body:
          Ducktrap::Node::Static
          Ducktrap::Node::Noop
    STR
  end
end
