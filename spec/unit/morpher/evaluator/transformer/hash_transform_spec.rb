require 'spec_helper'

describe Morpher::Evaluator::Transformer::HashTransform do

  let(:body_a) do
    s(:symbolize_key, 'foo', s(:guard, s(:primitive, String)))
  end

  let(:ast) do
    s(:hash_transform, body_a)
  end

  let(:object) do
    Morpher.evaluator(ast)
  end

  let(:evaluator_a) do
    Morpher.evaluator(body_a)
  end

  let(:input)  { { 'foo' => 'bar' } }
  let(:output) { { foo: 'bar'     } }

  describe '#call' do
    context 'with valid input' do
      subject { object.call(input) }

      it 'returns output' do
        should eql(output)
      end
    end
  end

  describe '#evaluation' do
    subject { object.evaluation(input) }

    let(:evaluations) { [evaluator_a.evaluation(input)] }

    context 'with valid input' do
      it 'returns evaluation' do
        should eql(Morpher::Evaluation::Nary.new(
          input:       input,
          evaluator:   object,
          evaluations: evaluations,
          output:      output
        ))
      end
    end
  end
end
