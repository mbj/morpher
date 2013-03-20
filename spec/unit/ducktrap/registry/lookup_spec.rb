require 'spec_helper'

describe Ducktrap::Registry, '#lookup' do
  subject { object.lookup(name, &block) }

  let(:object) { described_class.new }

  let(:name) { mock('Name') }
  let(:node) { mock('Node') }

  let(:block) { nil }

  context 'when name is registred' do
    before do
      object.register(name, node)
    end

    it { should be(node) }
  end

  context 'when name is NOT registred' do
    let(:other) { mock('Other') }
    let(:block) { proc { other } }

    it { should be(other) }
  end
end
