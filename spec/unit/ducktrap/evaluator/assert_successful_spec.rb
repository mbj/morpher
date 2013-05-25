require 'spec_helper'

describe Ducktrap::Evaluator, '#assert_successful' do
  let(:object) { class_under_test.new(context, input) }
  
  let(:context) { mock('Context') }
  let(:input)   { mock('Input')   }

  subject { object.assert_successful }

  context 'when process is not successful' do

    let(:class_under_test) do
      Class.new(described_class) do
        def process
          error
        end
      end
    end

    it 'should raise error' do
      expect { subject }.to raise_error(Ducktrap::FailedTransformationError.new(object))
    end
  end

  context 'when process is successful' do

    let(:class_under_test) do
      Class.new(described_class) do
        def process
          :result
        end
      end
    end

    it { should be(object) }
  end
end
