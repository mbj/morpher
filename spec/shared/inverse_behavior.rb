# encoding: utf-8

shared_examples_for 'an invalid input' do
  its(:valid?) { should be_false }

  it 'should raise error on attribute access' do
    expect { subject.attributes }.to raise_error(RuntimeError,'Attempt to access attributes on invalid input')
  end

  its(:errors) { should_not be_empty }
end

shared_examples_for 'a valid input' do
  it 'should be valid' do
    unless subject.valid?
      fail Input::Controller.format_errors(subject)
    end
  end

  its(:attributes) { should eql(expected_attributes) }
  its(:errors)     { should be_empty }
end

shared_examples_for 'an input controller' do
  context 'with empty input' do
    let(:input) { {} }

    it_should_behave_like 'an invalid input'
  end

  context 'when param is not a hash' do
    let(:input) { 'fooobaaar' }

    it_should_behave_like 'an invalid input'
  end

  context 'when valid' do
    it_should_behave_like 'a valid input'
  end
end
