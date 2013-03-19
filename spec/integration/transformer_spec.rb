require 'spec_helper'

describe 'simple ducktrap' do
  subject { loader.run(input) }

  let(:loader) do
    model = self.model

    Ducktrap::Node::Block.build do 
      anima_load(model) do
        collect_hash do
          fetch_key('name') do
            primitive(String)
            dump_key(:name)
          end
          fetch_key('amount') do
            primitive(String)
            fixnum_from_string
            dump_key(:amount)
          end
        end
      end
    end
  end

  specify 'inversing twice equals original' do
    loader.should eql(loader.inverse.inverse)
  end

  let(:model) do
    Class.new do
      include Adamantium, Anima.new(:name, :amount)
    end
  end

  let(:dumper) do
    loader.inverse
  end

  context 'when input is fully loadable' do
    let(:input) { { 'amount' => '1000', 'name' => 'Markus Schirp' } }

    it 'should not result in an error' do
      should be_successful
    end

    its(:output) { should eql(model.new(:name => 'Markus Schirp', :amount => 1000)) }

    it 'allows to round trip' do
      result = dumper.run(subject.output)
      result.output.should eql(input)
    end
  end

  context 'with invalid integer' do
    let(:input) { { 'amount' => '10a0', 'name' => 'Markus Schirp' } }

    it { should_not be_successful }

  end

  context 'when input is empty' do
    let(:input) { { 'amount' => '', 'name' => 'Markus Schirp' } }

    it { should_not be_successful }
  end

  context 'when input is missing attribute' do
    let(:input) { { 'name' => 'Markus Schirp' } }

    it { should_not be_successful }
  end

  context 'when input is in invalid format' do
    let(:input) { { 'amount' => [], 'name' => 'Markus Schirp' } }

    it { should_not be_successful }
  end
end
