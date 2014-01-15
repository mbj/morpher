require 'spec_helper'

describe Morpher::Evaluator::Predicate::Tautology do
  let(:object) { described_class.new }

  include_examples 'predicate evaluator'
  include_examples 'no negative example'

  let(:positive_input)  { double }
end
