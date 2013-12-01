# encoding: utf-8

shared_examples_for 'an evaluator' do
  it 'round trips evaluators' do
    object.inverse.inverse.should eql(object)
  end

  it 'returns semantically correct evaluations on #evaluation' do
    evaluation = object.evaluation(valid_input)
    expect(evaluation.evaluator).to eql(object)
    expect(evaluation.input).to eql(valid_input)
  end
end

shared_examples_for 'a predicate evaluator' do
  it_should_behave_like 'an evaluator'

  context 'with valid input' do

    it 'evaluates to true' do
      expect(object.call(valid_input)).to be(true)
    end

    it 'evaluates to false on inverse' do
      expect(object.inverse.call(valid_input)).to be(false)
    end

    it 'evaluates to the same output under #evaluation' do
      expect(object.evaluation(valid_input).output).to be(true)
    end

  end

  context 'with invalid input' do

    it 'evaluates to false' do
      expect(object.call(invalid_input)).to be(false)
    end

    it 'evaluates to true on inverse' do
      expect(object.inverse.call(invalid_input)).to be(true)
    end

    it 'evaluates to the same output under #evaluation' do
      expect(object.evaluation(invalid_input).output).to be(false)
    end
  end
end

shared_examples_for 'a transforming evaluator' do
  it_should_behave_like 'an evaluator'

  context 'with valid input' do
    it 'round trips representations via #call' do
      forward = object.call(valid_input)
      expect(object.inverse.call(forward)).to eql(valid_input)
    end

    it 'round trips representations via #evaluation' do
      forward = object.evaluation(valid_input).output
      expect(evaluation.success?).to be(true)
      expect(object.inverse.call(forward).output).to eql(valid_input)
    end
  end

  context 'with invalid input' do
    it 'raises error for #call' do
      expect { object.call(invalid_input) }.to raise_error(Morpher::TransformError)
    end

    it 'returns error evaluator for #evaluation' do
      evaluation = object.evaluation(invalid_input)
      expect(evaluation.success?).to be(false)
      expect(evaluation.output).to be(Morpher::Undefined)
    end
  end
end
