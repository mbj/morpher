require 'spec_helper'

describe Ducktrap::Builder, '.new' do
  let(:object) { class_under_test }

  let(:class_under_test) do
    Class.new(described_class)
  end

  let(:klass) { mock('Class') }

  subject { object.new(klass, &block) }

  context 'when called with block argument' do
    let(:yields) { [] }
    let(:block) { proc { |argument| yields << argument } }

    it { should eql(class_under_test.new(klass)) }

    it 'should yield builder' do
      subject
      yields.should eql([subject])
    end

    its(:klass) { should be(klass) }
  end

  context 'when called with block argument' do
    let(:selfs) { [] }
    let(:block) { selfs = self.selfs; proc { selfs << self } }

    it { should eql(class_under_test.new(klass)) }

    it 'should execute block within builder' do
      subject
      selfs.should eql([subject])
    end

    its(:klass) { should be(klass) }
  end
end
