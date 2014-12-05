# encoding: UTF-8

require 'spec_helper'

describe Morpher::Evaluator::Transformer::Name do
  let(:object)  { described_class.new(name, operand) }
  let(:name)    { :test }
  let(:operand) { Morpher.compile(s(:eql, s(:input), s(:static, :valid))) }

  let(:valid_input)     { :valid }
  let(:expected_output) { true }

  include_examples 'transforming evaluator'
  include_examples 'intransitive evaluator'
  include_examples 'no invalid input'

  it 'makes the given name accessible in the evaluation tree' do
    expect(object.evaluation(valid_input).evaluator.param).to eql(name)
  end
end
