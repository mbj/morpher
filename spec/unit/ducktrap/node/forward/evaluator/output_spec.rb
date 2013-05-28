require 'spec_helper'

describe Ducktrap::Node::Forward::Evaluator, '#output' do
  let(:object) { described_class.new(context, input) }

  let(:context) { mock('Context', :operand => operand)           }
  let(:operand) { Ducktrap::Node::Static.new(:forward, :inverse) }
  let(:input)   { mock('Input')                                  }

  subject { object.output }

  it { should eql(:forward) }
end
