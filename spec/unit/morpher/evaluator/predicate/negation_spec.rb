require 'spec_helper'

describe Morpher::Evaluator::Predicate::Negation do
  let(:object) { described_class.new(Morpher::Evaluator::Predicate::EQL.new('foo')) }

  let(:positive_input) { 'bar' }
  let(:negative_input) { 'foo' }

  include_examples 'predicate evaluator'
end
