require 'spec_helper'

describe Ducktrap::Node::GuardNil, '#inverse' do
  subject { object.inverse }

  let(:object)  { described_class.new(operand)         }
  let(:operand) { mock('Operand', :inverse => inverse) }
  let(:inverse) { mock('Inverse')                      }

  it { should eql(described_class.new(inverse)) }
end
