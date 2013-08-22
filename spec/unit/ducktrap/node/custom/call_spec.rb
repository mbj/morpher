require 'spec_helper'

describe Ducktrap::Node::Custom, '#call' do
  let(:object) { described_class.new(forward, inverse) }

  let(:input)  { double('Input') }
  let(:output) { double('Output') }

  let(:arguments) { [] }

  let(:forward) {  lambda { |input| arguments << input; output } }
  let(:inverse) { double('Inverse')                                }

  subject { object.call(input) }

  it { should eql(Ducktrap::Evaluator::Static.new(object, input, output)) }

  it 'should call with correct argument' do
    expect { subject }.to change { arguments }.from([]).to([input])
  end
end
