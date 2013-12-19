require 'spec_helper'

describe Morpher::Evaluator::Predicate::Tautology do
  let(:object) { described_class.new }

  include_examples 'evaluator'

  let(:valid_input) { double }

  context '#call' do
    subject { object.call(valid_input) }

    it { should be(true) }
  end
end
