require 'spec_helper'

describe Ducktrap::Node::Key::Evaluator, '#output' do

  subject { object.key }

  let(:object) { class_under_test.new(context, input) }

  let(:class_under_test) do
    Class.new(described_class) do
      public :key
    end
  end

  let(:key)     { mock('Key') }
  let(:value)   { mock('Value') }

  let(:context) { mock('Context', :key => key, :operand => operand) }
  let(:operand) { Ducktrap::Node::Static.new(:forward, :inverse)    }

    let(:input)   { { key => value } }

  it { should be(key) }

  it_should_behave_like 'an idempotent method'
end
