require 'spec_helper'

describe Morpher::Evaluator::Transformer::Block do


  let(:ast) do
    s(:block, body_a, body_b)
  end

  let(:object) do
    Morpher.evaluator(ast)
  end

  let(:evaluator_a) do
    Morpher.evaluator(body_a)
  end

  let(:evaluator_b) do
    Morpher.evaluator(body_b)
  end

  context 'intransitive' do
    include_examples 'intransitive evaluator'

    let(:valid_input)     { { 'foo' => 'bar' } }
    let(:expected_output) { true               }

    let(:body_a) do
      s(:key_fetch, 'foo')
    end

    let(:body_b) do
      s(:primitive, String)
    end

    context '#evaluation' do
      subject { object.evaluation(valid_input) }

      let(:evaluations) do
        [
          evaluator_a.evaluation(valid_input),
          evaluator_b.evaluation('bar')
        ]
      end

      context 'with valid input' do
        it 'returns evaluation' do
          should eql(Morpher::Evaluation::Nary.new(
            input:       valid_input,
            evaluator:   object,
            evaluations: evaluations,
            output:      expected_output
          ))
        end
      end
    end
  end
end
