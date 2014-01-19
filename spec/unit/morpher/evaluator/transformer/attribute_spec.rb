require 'spec_helper'

describe Morpher::Evaluator::Transformer::Attribute do
  let(:object) { described_class.new(:length) }

  include_examples 'transforming evaluator'
  include_examples 'intransitive evaluator'
  include_examples 'no invalid input'

  let(:valid_input)     { 'foo' }
  let(:expected_output) { 3     }
end
