require 'spec_helper'

describe Ducktrap::Node::Key::Add, '#call' do
  subject { object.call(input) }

  let(:object)            { described_class.new(operand, key)                                       }
  let(:key)               { double('Key')                                                             }
  let(:operand)           { double('Operand', :call => operand_evaluator)                                 }
  let(:operand_evaluator) { double('Operand Evaluator', :output => operand_output, :successful? => true, :frozen? => true) }
  let(:operand_output)    { double('Operand Output')                                                  }
  let(:input)             { { :foo => :bar }.freeze }


  its(:output)  { should eql(:foo => :bar, key => operand_output) }
end
