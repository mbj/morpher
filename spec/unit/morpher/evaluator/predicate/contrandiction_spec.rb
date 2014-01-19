# encoding: UTF-8

require 'spec_helper'

describe Morpher::Evaluator::Predicate::Contradiction do
  let(:object) { described_class.new }

  include_examples 'predicate evaluator'
  include_examples 'no negative example'

  let(:expected_positive_output) { false }

  let(:positive_input)  { double }
  let(:expected_output) { false }
end
