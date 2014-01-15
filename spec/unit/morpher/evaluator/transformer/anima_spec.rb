require 'spec_helper'

describe Morpher::Evaluator::Transformer::Anima::Dump do
  let(:model) do
    Class.new do
      include Anima.new(:foo)
    end
  end

  let(:object) { described_class.new(model) }

  let(:expected_output) { { foo: :bar }              }
  let(:valid_input)     { model.new(expected_output) }

  include_examples 'transforming evaluator'
  include_examples 'transitive evaluator'
  include_examples 'no invalid transform'
end

describe Morpher::Evaluator::Transformer::Anima::Load do
  let(:model) do
    Class.new do
      include Anima.new(:foo)
    end
  end

  let(:object) { described_class.new(model) }

  let(:valid_input)     { { foo: :bar }          }
  let(:expected_output) { model.new(valid_input) }
  let(:invalid_input)   { { bar: :baz }          }

  include_examples 'transforming evaluator'
  include_examples 'transitive evaluator'
end
