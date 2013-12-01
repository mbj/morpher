require 'spec_helper'

describe Morpher::Evaluator::Predicate::Contradiction do
  let(:object) { described_class.new }

  it_should_behave_like 'an evaluator'

  context '#call' do
    subject { object.call(input) }

    let(:input) { double }

    it { should be(false) }
  end
end
