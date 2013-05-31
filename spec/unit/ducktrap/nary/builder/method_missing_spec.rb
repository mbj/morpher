require 'spec_helper'

describe Ducktrap::Nary::Builder, '#method_missing' do
  let(:object) { described_class.new(klass)    }
  let(:klass)  { Ducktrap::Node::Block         }

  context 'known nullary DSL method' do
    subject { object.noop }
    it 'should add node to body' do
      node = Ducktrap::Node::Noop.instance
      expect { subject }.to change { object.body }.from([]).to([node])
    end
  end

  context 'known unary DSL method' do
    subject { object.guard_nil { noop } }
    it 'should add node to body' do
      node = Ducktrap::Node::GuardNil.new(
        Ducktrap::Node::Block.new(
          [Ducktrap::Node::Noop.instance]
        )
      )
      expect { subject }.to change { object.body }.from([]).to([node])
    end
  end

  context 'unknown DSL method' do
    subject { object.unknown }

    it 'should raise error' do
      message = 
        if Devtools.rbx? 
          %q(undefined method `unknown' on an instance of Ducktrap::Nary::Builder)
        else
          %q(undefined method `unknown' for #<Ducktrap::Nary::Builder klass=Ducktrap::Node::Block>)
        end

      expect { subject }.to raise_error(
        NoMethodError, 
        message
      )
    end
  end
end
