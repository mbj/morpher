require 'spec_helper'

describe Ducktrap::Disjunction, '#run' do
  subject { object.run(input) }

  let(:object) { described_class.new(body) }

  let(:input) { mock('Input') }

  context 'when body is empty' do
    let(:body) { [] }

    its(:output)      { should be(input) }
    its(:successful?) { should be(true) }
  end

# context 'when body has one element' do
#   let(:body) { [operand] }

#   let(:operand_result) { mock('Operand Result', :output => output, :successful => successful?) }

#   context 'and operand is successful' do
#     its(:output) { should be(operand_output) }
#     its(:successful?) { should be(true) }
#   end

#   context 'and operand is unsuccessful' do
#   end
# end
end
