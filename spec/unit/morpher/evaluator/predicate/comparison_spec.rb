# encoding: UTF-8

require 'spec_helper'

describe Morpher::Evaluator::Predicate::EQL do
  let(:object) { described_class.new(left, right) }

  let(:left)  { Morpher.compile(s(:static, 1.0)) }
  let(:right) { Morpher.compile(s(:input))       }

  let(:positive_input) { 1.0 }
  let(:negative_input) { 1   }

  include_examples 'predicate evaluator'
end

describe Morpher::Evaluator::Predicate::LT do
  let(:object) { described_class.new(left, right) }

  let(:left)  { Morpher.compile(s(:static, 1.0)) }
  let(:right) { Morpher.compile(s(:input))       }

  let(:positive_input) { 2.0 }
  let(:negative_input) { 1.0   }

  include_examples 'predicate evaluator'
end

describe Morpher::Evaluator::Predicate::LTE do
  let(:object) { described_class.new(left, right) }

  let(:left)  { Morpher.compile(s(:static, 1.0)) }
  let(:right) { Morpher.compile(s(:input))       }

  let(:positive_input) { 1.0 }
  let(:negative_input) { 0.0   }

  include_examples 'predicate evaluator'
end

describe Morpher::Evaluator::Predicate::GT do
  let(:object) { described_class.new(left, right) }

  let(:left)  { Morpher.compile(s(:static, 1.0)) }
  let(:right) { Morpher.compile(s(:input))       }

  let(:positive_input) { 0.0 }
  let(:negative_input) { 2.0   }

  include_examples 'predicate evaluator'
end

describe Morpher::Evaluator::Predicate::GTE do
  let(:object) { described_class.new(left, right) }

  let(:left)  { Morpher.compile(s(:static, 1.0)) }
  let(:right) { Morpher.compile(s(:input))       }

  let(:positive_input) { 1.0 }
  let(:negative_input) { 2.0   }

  include_examples 'predicate evaluator'
end
