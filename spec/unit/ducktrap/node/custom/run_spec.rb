require 'spec_helper'

describe Ducktrap::Node::Custom, '#run' do 
  let(:object) { described_class.new(forward, inverse) }

  let(:input)  { mock('Input') }
  let(:output) { mock('Output') }

  let(:arguments) { [] }

  let(:forward) {  lambda { |input| arguments << input; output } }
  let(:inverse) { mock('Inverse')                                }

  subject { object.run(input) }

  it { should eql(Ducktrap::Evaluator::Static.new(object, input, output)) }

  it 'should call with correct argument' do
    expect { subject }.to change { arguments }.from([]).to([input])
  end
end
