# encoding: utf-8

shared_examples_for 'an #inverse method' do
  it 'should round trip' do
    object.inverse.inverse.should eql(object)
  end
end
