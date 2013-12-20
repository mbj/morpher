# encoding: utf-8

shared_examples_for 'evaluator' do
  it 'round trips evaluators' do
    object.inverse.inverse.should eql(object)
  end

  it 'returns correct output on #call' do
    output = object.call(valid_input)
    expect(output).to eql(expected_output)
  end

  it 'returns semantically correct evaluations on #evaluation' do
    evaluation = object.evaluation(valid_input)
    expect(evaluation.success?).to be(true)
    expect(evaluation.evaluator).to eql(object)
    expect(evaluation.input).to eql(valid_input)
    expect(evaluation.output).to eql(expected_output)
  end
end

shared_examples_for 'predicate evaluator' do
  include_examples 'evaluator'

  let(:expected_output) { true }

  context 'with positive input' do

    it 'evaluates to true' do
      expect(object.call(valid_input)).to be(true)
    end

    it 'evaluates to false on inverse' do
      expect(object.inverse.call(valid_input)).to be(false)
    end

    it 'evaluates to the same output under #evaluation' do
      evaluation = object.evaluation(valid_input)
      expect(evaluation.success?).to be(true)
      expect(evaluation.output).to be(true)

      evaluation = object.inverse.evaluation(valid_input)
    end

  end

  pending 'with invalid input' do

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

shared_examples_for 'transitive evaluator' do
  include_examples 'evaluator'

  it 'signals transitivity via #transitive?' do
    expect(object.transitive?).to be(true)
  end

  it 'round trips via #evaluation' do
    evaluation = object.evaluation(valid_input)
    expect(evaluation.success?).to be(true)
    evaluation = object.inverse.evaluation(evaluation.output)
    expect(evaluation.output).to eql(valid_input)
    expect(evaluation.success?).to be(true)
  end

  it 'round trips via #call' do
    forward = object.call(valid_input)
    expect(object.inverse.call(forward)).to eql(valid_input)
  end

end

shared_examples_for 'intransitive evaluator' do
  include_examples 'evaluator'

  it 'signals intransitivity via #transitive?' do
    expect(object.transitive?).to be(false)
  end

  it 'round trips via #call' do
    forward = object.call(valid_input)
    expect(object.inverse.call(forward)).not_to eql(valid_input)
  end

end

shared_examples_for 'transforming evaluator' do
  include_examples 'evaluator'

  context 'with valid input' do
    it 'transforms to expected output via #call' do
      result = object.call(valid_input)
      expect(result).to eql(expected_output)
    end

    it 'transforms to expected output via #evaluation' do
      evaluation = object.evaluation(valid_input)
      expect(evaluation.success?).to eql(true)
      expect(evaluation.output).to eql(expected_output)
    end
  end

  pending 'with invalid input' do
    it 'raises error for #call' do
      expect { object.call(invalid_input) }.to raise_error(Morpher::Evaluator::Transformer::TransformError)
    end

    it 'returns error evaluator for #evaluation' do
      evaluation = object.evaluation(invalid_input)
      expect(evaluation.success?).to eql(false)
      expect(evaluation.output).to be(Morpher::Undefined)
    end
  end
end
