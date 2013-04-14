require 'spec_helper'

describe Ducktrap::Node::Block::Evaluator, '#output' do
  subject { object.output }

  let(:object)  { described_class.new(context, input) }
  let(:context) { mymock('Context', :body => body)      }

  let(:input)  { mymock('Input') }

  context 'with empty body' do
    let(:body) { [] }

    it { should be(input) }

    it_should_behave_like 'an idempotent method'
  end

  def mymock(name, attributes={})
    mock(name, attributes.merge(:frozen? => true))
  end

  context 'with body' do
    let(:body) { [trap_a, trap_b] }

    let(:trap_a) { mymock('Ducktrap A') }
    let(:trap_b) { mymock('Ducktrap B') }

    let(:input_a) { mymock('Input A') }
    let(:input_b) { mymock('Input B') }

    let(:output_a) { mymock(:output_a) }
    let(:output_b) { mymock(:output_b) }

    before do
      trap_a.stub(:run => evaluator_a)
      trap_b.stub(:run => evaluator_b)
    end

    context 'without failures' do
      let(:evaluator_a) { Ducktrap::Evaluator::Static.new(context, input_a, output_a) }
      let(:evaluator_b) { Ducktrap::Evaluator::Static.new(context, input_b, output_b) }

      it { should be(output_b) }
      
      it_should_behave_like 'an idempotent method'
    end

    context 'with late failure' do
      let(:evaluator_a) { Ducktrap::Evaluator::Static.new(context, input_a, output_a) }
      let(:evaluator_b) { Ducktrap::Evaluator::Invalid.new(context, input_b) }


      it { should eql(Ducktrap::Error.new(evaluator_b, input)) }

      it_should_behave_like 'an idempotent method'
    end

    context 'with early failure' do
      let(:evaluator_a) { Ducktrap::Evaluator::Invalid.new(context, input_a) }
      let(:evaluator_b) { Ducktrap::Evaluator::Invalid.new(context, input_b) }

      it { should eql(Ducktrap::Error.new(evaluator_a, input)) }

      it 'should not execute later ducktraps' do
        trap_b.should_not_receive(:run)
        subject
      end

      it_should_behave_like 'an idempotent method'
    end
  end
end
