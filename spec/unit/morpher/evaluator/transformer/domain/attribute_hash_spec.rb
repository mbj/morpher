# encoding: UTF-8

require 'spec_helper'

describe Morpher::Evaluator::Transformer::Domain::AttributeHash do

  let(:model) do
    Class.new do
      include Anima.new(:foo, :bar)

      attr_accessor :foo, :bar
    end
  end

  let(:param) do
    described_class::Param.new(model, [:foo, :bar])
  end

  describe Morpher::Evaluator::Transformer::Domain::AttributeHash::Dump do

    let(:object) { described_class::Dump.new(param) }

    let(:expected_output) { { foo: :foo, bar: :bar } }

    let(:valid_input) do
      model.new(foo: :foo, bar: :bar)
    end

    include_examples 'transforming evaluator'
    include_examples 'transitive evaluator'
    include_examples 'no invalid input'

  end

  describe Morpher::Evaluator::Transformer::Domain::AttributeHash::Load do
    let(:object) { described_class::Load.new(param) }

    let(:valid_input)     { { foo: :foo, bar: :bar } }

    let(:expected_output) do
      model.new(foo: :foo, bar: :bar)
    end

    include_examples 'transforming evaluator'
    include_examples 'transitive evaluator'
    include_examples 'no invalid input'
  end
end
