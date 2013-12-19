require 'spec_helper'

describe Morpher::Evaluator::Transformer::Block do

  let(:body_a) do
    s(:key_fetch, 'foo')
  end

  let(:body_b) do
    s(:primitive, String)
  end

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

  let(:input)  { { 'foo' => 'bar' } }
  let(:output) { true               }

  describe '#inverse' do
    subject { object.inverse }

    it { should eql(described_class.new([evaluator_b.inverse, evaluator_a.inverse])) }
  end

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

    let(:evaluations) do
      [
        evaluator_a.evaluation(input),
        evaluator_b.evaluation('bar')
      ]
    end

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
