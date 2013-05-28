require 'spec_helper'

describe Ducktrap::Node::Custom::Builder, '#output' do 
  let(:object) { described_class.new(klass, &block) }

  let(:klass) { Ducktrap::Node::Custom }

  subject { object.object }

  context 'without directions' do
    let(:block) { proc {} }

    it 'should raise error' do
      expect { subject }.to raise_error(RuntimeError, 'No forward block specified!')
    end

  end

  context 'with forward direction' do
    let(:block) { proc { forward { |input| input } } }

    it 'should raise error' do
      expect { subject }.to raise_error(RuntimeError, 'No inverse block specified!')
    end
  end

  context 'with forward and inverse direction' do
    let(:block) { forward, inverse = self.forward, self.inverse; proc { forward(&forward); inverse(&inverse) } }

    let(:forward) { proc {} }
    let(:inverse) { proc {} }

    it { should eql(klass.new(forward, inverse)) }
  end

  # kill some mutations
  context 'with forward and inverse direction chained' do
    let(:block) { forward, inverse = self.forward, self.inverse; proc { forward(&forward).inverse(&inverse) } }

    let(:forward) { proc {} }
    let(:inverse) { proc {} }

    it { should eql(klass.new(forward, inverse)) }
  end

  context 'with forward and inverse direction chained #2' do
    let(:block) { forward, inverse = self.forward, self.inverse; proc { inverse(&inverse).forward(&forward) } }

    let(:forward) { proc {} }
    let(:inverse) { proc {} }

    it { should eql(klass.new(forward, inverse)) }
  end
end
