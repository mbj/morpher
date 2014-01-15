require 'spec_helper'

describe Morpher::Evaluator::Predicate::EQL do
  let(:object) { described_class.new(1.0) }

  let(:positive_input) { 1.0 }
  let(:negative_input) { 1   }

  include_examples 'predicate evaluator'
end
