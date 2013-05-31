require 'spec_helper'

describe Ducktrap::Node::Hash::Transform, '#inverse' do
  let(:object) { described_class.new(body) }

  let(:noop) { Ducktrap::Node::Noop.instance }

  let(:body) do
    [
      Ducktrap::Node::Key::Fetch.new(noop, :foo),
      Ducktrap::Node::Key::Fetch.new(noop, :bar)
    ]
  end

  let(:inverse_body) do
    [
      Ducktrap::Node::Key::Dump.new(noop, :foo),
      Ducktrap::Node::Key::Dump.new(noop, :bar)
    ]
  end

  subject { object.inverse }

  it { should eql(Ducktrap::Node::Hash::Transform.new(inverse_body)) }

  it_should_behave_like 'an #inverse method'
end
