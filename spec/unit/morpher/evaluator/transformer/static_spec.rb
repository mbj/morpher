# encoding: UTF-8

require 'spec_helper'

describe Morpher::Evaluator::Transformer::Static do
  let(:object) { described_class.new(value) }

  let(:value) { double('Value') }

  let(:valid_input)     { double('Input') }
  let(:expected_output) { value           }

  include_examples 'transforming evaluator'
  include_examples 'no invalid input'
end
