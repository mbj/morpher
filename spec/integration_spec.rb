require 'spec_helper'

describe Ducktrap do
  include Mutant::NodeHelpers

  def self.strip(text)
    return text if text.empty?
    lines = text.lines
    match = /\A[ ]*/.match(lines.first)
    range = match[0].length..-1
    source = lines.map do |line|
      line[range]
    end.join
    source.chomp
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
    s(:attribute, :attribute_a, s(:eql, 'foo'))
  end

  specify 'allows predicates to be run from sexp' do

    valid = double(attribute_a: 'foo')
    invalid = double(attribute_a: 'bar')

    evaluator = Ducktrap.evaluator(predicate_sexp)

    expect(evaluator.call(valid)).to be(true)
    expect(evaluator.call(invalid)).to be(false)

    tracker = Ducktrap.tracker(predicate_sexp)

    result = tracker.call(valid)

    expect(result.success?).to be(true)
    expect(result.output).to be(true)

    result = tracker.call(invalid)

    expect(result.success?).to be(false)

    expect(result.error.description).to eql(<<-TEXT)
    TEXT
  end
end
