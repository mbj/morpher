require 'spec_helper'

describe Morpher do
  let(:object) { described_class }

  describe '.sexp' do
    subject { object.sexp(&block) }

    context 'with no block given' do
      let(:block) { nil }

      it 'raises an exception' do
        expect { subject }.to raise_error
      end
    end

    context 'with block given' do
      let(:block) { proc { s(:foo); s(:bar) } }

      it 'allows to use sexp dsl and returns last value' do
        should == AST::Node.new(:bar)
      end
    end
  end

  describe '.build' do
    subject { object.build(&block) }

    context 'with no block given' do
      let(:block) { nil }

      it 'raises an exception' do
        expect { subject }.to raise_error
      end
    end

    context 'with block given' do
      let(:block) { proc { s(:foo); s(:true) } }

      it 'allows to use sexp dsl and returns last value compiled' do
        should eql(Morpher.compile(s(:true)))
      end
    end
  end
end
