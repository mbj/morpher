require 'spec_helper'

describe Ducktrap::Node::Hash::Transform::Evaluator, '#output' do
  let(:object) { described_class.new(context, input) }

  let(:context) { mock('Context', :body => body) }

  let(:noop) { Ducktrap::Node::Noop.instance }

  subject { object.output }

  context 'with empty body' do
    let(:body) { [] }
    let(:input) { {} }

    it { should eql({}) }

    it_should_behave_like 'an idempotent method'
  end

  context 'with filled body' do

    context 'without errors' do
      let(:body) do
        [
          Ducktrap::Node::Key::Fetch.new(Ducktrap::Node::Key::Dump.new(noop, :foo), 'foo')
        ]
      end

      let(:input) { { 'foo' => :bar } }

      it { should eql(:foo => :bar) }

      it_should_behave_like 'an idempotent method'
    end

    context 'with error' do
      let(:body) do
        [
          Ducktrap::Node::Key::Fetch.new(Ducktrap::Node::Invalid.instance, :foo)
        ]
      end

      let(:input) { { 'foo' => :bar } }

      it { should eql(Ducktrap::Error.new(body.first.call(input), input)) }

      it_should_behave_like 'an idempotent method'
    end
  end
end
