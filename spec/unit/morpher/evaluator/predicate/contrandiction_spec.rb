require 'spec_helper'

describe Morpher::Evaluator::Predicate::Contradiction do
  let(:object) { described_class.new }

  include_examples 'evaluator'

  let(:valid_input) { double }
  let(:expected_output) { false }
end
