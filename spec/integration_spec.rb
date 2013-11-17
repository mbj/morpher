require 'spec_helper'

describe Morpher do
  include Mutant::NodeHelpers

  def strip(text)
    return text if text.empty?
    lines = text.lines
    match = /\A[ ]*/.match(lines.first)
    range = match[0].length..-1
    source = lines.map do |line|
      line[range]
    end.join
    source.chomp << "\n"
  end

  class Foo
    include Anima.new(:attribute_a, :b)
  end

  class Bar
    include Anima.new(:baz)
  end

  class Baz
    include Anima.new(:value)
  end

  let(:tree_a) do
    Foo.new(
      attribute_a: Baz.new(value: :value_a),
      attribute_b: :value_b
    )
  end

  let(:primitive_tree) do
  end

  let(:predicate_sexp) do
    s(:block,
      s(:key_fetch, :attribute_a),
      s(:eql, 'foo')
    )
  end

  specify 'allows predicates to be run from sexp' do

    valid = { attribute_a: 'foo' }
    invalid = { attribute_a: 'bar' }

    evaluator = Morpher.evaluator(predicate_sexp)

    expect(evaluator.call(valid)).to be(true)
    expect(evaluator.call(invalid)).to be(false)

    evaluation = evaluator.evaluation(valid)

    expect(evaluation.output).to be(true)
    expect(evaluation.input).to be(valid)
    expect(evaluation.description).to eql(strip(<<-TEXT))
      Morpher::Evaluation::Nary
        evaluator: Morpher::Evaluator::NAry::Block
        input: {:attribute_a=>"foo"}
        output: true
        evaluations:
          Morpher::Evaluation
            input: {:attribute_a=>"foo"}
            output: "foo"
            evaluator:
              Morpher::Evaluator::Nullary::Parameterized::KeyFetch
                param: :attribute_a
          Morpher::Evaluation
            input: "foo"
            output: true
            evaluator:
              Morpher::Evaluator::Nullary::Parameterized::EQL
                param: "foo"
    TEXT
  end
end
