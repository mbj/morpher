require 'spec_helper'

describe Morpher::Evaluator::Predicate::Unary::Negation do
  let(:object) { described_class.new(Morpher::Evaluator::Predicate::EQL.new('foo')) }

  let(:positive_input) { 'bar' }
  let(:negative_input) { 'foo' }

  include_examples 'predicate evaluator'

  context '#evaluation' do
    subject { object.evaluation('foo') }

    its(:operand_output) { should be(true) }
  end
end
