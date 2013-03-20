require 'spec_helper'

describe Ducktrap::Node::Key::Add, '#run' do
  subject { object.run(input) }

  let(:object)         { described_class.new(operand, key)                                       }
  let(:key)            { mock('Key')                                                             }
  let(:operand)        { mock('Operand', :run => operand_evaluator)                                 }
  let(:operand_evaluator) { mock('Operand Evaluator', :output => operand_output, :successful? => true, :frozen? => true) }
  let(:operand_output) { mock('Operand Output')                                                  }
  let(:input)          { { :foo => :bar }.freeze }


  its(:output)  { should eql(:foo => :bar, key => operand_output) }
end
