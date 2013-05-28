require 'spec_helper'

describe Ducktrap::Nary::Builder, '#add' do
  let(:object) { described_class.new(klass) }
  let(:klass)  { Ducktrap::Node::Block      }

  let(:node)  { Ducktrap::Node::Noop.instance }

  subject { object.add(node) }

  it 'should add node to body' do
    expect { subject }.to change { object.body }.from([]).to([node])
  end

  it_should_behave_like 'a command method'
end
