require 'spec_helper'

describe Morpher::Evaluator::Predicate::Contradiction do
  let(:object) { described_class.new }

  include_examples 'evaluator'

  let(:valid_input) { double }

  context '#call' do
    subject { object.call(valid_input) }

    it { should be(false) }
  end
end
