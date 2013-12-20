require 'spec_helper'

describe Morpher::Evaluator::Transformer::HashTransform do

  let(:ast) do
    s(:hash_transform, body_a)
  end

  let(:object) do
    Morpher.evaluator(ast)
  end

  let(:evaluator_a) do
    Morpher.evaluator(body_a)
  end

  context 'intransitive' do
    include_examples 'intransitive evaluator'

    let(:valid_input)     { { 'foo' => 'bar' } }
    let(:expected_output) { { foo: true      } }

    let(:body_a) do
      s(:symbolize_key, 'foo', s(:primitive, String))
    end
  end

  context 'transitive' do
    include_examples 'transitive evaluator'

    let(:body_a) do
      s(:symbolize_key, 'foo', s(:guard, s(:primitive, String)))
    end

    let(:valid_input)     { { 'foo' => 'bar' } }
    let(:expected_output) { { foo: 'bar'     } }

  end
end
