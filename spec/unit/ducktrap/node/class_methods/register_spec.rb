require 'spec_helper'

describe Ducktrap::Node, '.register' do
  subject do
    Class.new(described_class) do
      include Ducktrap::Nullary
      register :foo
    end
  end

  it 'should register class' do
    subject
    node = Ducktrap.build { foo }.body.first
    node.class.should be(subject)
  end
end
