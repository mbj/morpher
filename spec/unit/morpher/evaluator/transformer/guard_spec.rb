# encoding: UTF-8

require 'spec_helper'

describe Morpher::Evaluator::Transformer::Guard do
  let(:object) { described_class.new(predicate) }

  let(:predicate) { Morpher.compile(s(:primitive, String)) }

  let(:valid_input)     { 'foo'       }
  let(:invalid_input)   { :foo        }
  let(:expected_output) { valid_input }

  include_examples 'transitive evaluator'
  include_examples 'transforming evaluator'
end
