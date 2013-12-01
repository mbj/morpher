require 'spec_helper'

describe Morpher::Evaluator::Predicate::Primitive::Exact do
  let(:object) { described_class.new(Morpher::Evaluator) }

  describe '#call' do
    subject { object.call(input) }

    context 'with input of exactly the same type' do
      let(:input) { Morpher::Evaluator.allocate }
      it { should be(true) }
    end

    context 'with input of nearly the same type' do
      let(:input) { Morpher::Evaluator::Predicate.allocate }
      it { should be(false) }
    end

    context 'with input of totally another type' do
      let(:input) { "foo" }
      it { should be(false) }
    end
  end
end

describe Morpher::Evaluator::Predicate::Primitive::Permissive do
  let(:object) { described_class.new(Morpher::Evaluator) }

  describe '#call' do
    subject { object.call(input) }

    context 'with input of exactly the same type' do
      let(:input) { Morpher::Evaluator.allocate }
      it { should be(true) }
    end

    context 'with input of nearly the same type' do
      let(:input) { Morpher::Evaluator::Predicate.allocate }
      it { should be(true) }
    end

    context 'with input of totally another type' do
      let(:input) { "foo" }
      it { should be(false) }
    end
  end
end
