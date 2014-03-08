# encoding: UTF-8

require 'spec_helper'

describe Morpher::Evaluator::Transformer::Domain::InstanceVariables::Dump do
  let(:model) do
    Class.new do
      include Concord.new(:foo, :bar)
    end
  end

  let(:object) { described_class.new(model) }

  let(:expected_output) { { foo: :foo, bar: :bar } }
  let(:valid_input)     { model.new(:foo, :bar)    }

  include_examples 'transforming evaluator'
  include_examples 'transitive evaluator'
  include_examples 'no invalid input'
end

describe Morpher::Evaluator::Transformer::Domain::InstanceVariables::Load do
  let(:model) do
    Class.new do
      include Concord.new(:foo, :bar)
    end
  end

  let(:object) { described_class.new(model) }

  let(:valid_input)     { { foo: :foo, bar: :bar } }
  let(:expected_output) { model.new(:foo, :bar)    }

  include_examples 'transforming evaluator'
  include_examples 'transitive evaluator'
  include_examples 'no invalid input'
end
