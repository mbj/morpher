# encoding: UTF-8

require 'spec_helper'

describe Morpher::Evaluator::Transformer::Custom do
  let(:object) { described_class.new(param) }

  let(:param)  { [a, b] }

  let(:a) { ->(_input) { :a } }
  let(:b) { ->(_input) { :b } }

  let(:valid_input)     { double('Input') }
  let(:expected_output) { :a              }

  include_examples 'transforming evaluator'
  include_examples 'no invalid input'
end
