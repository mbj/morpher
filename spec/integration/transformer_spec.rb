require 'spec_helper'

describe 'simple ducktrap' do
  subject { loader.run(input) }

  let(:loader) do
    model = self.model

    Ducktrap::Block.build do 
      params_hash_from_url_encoded_string
      attributes_hash_from_params_hash_extraction do 
        attribute_from_params_hash :name do
          primitive(String)
        end

        attribute_from_params_hash :amount do
          fixnum_from_string
        end
      end
      anima_from_attributes_hash(model)
    end
  end

  specify 'inversing twice equals original' do
    loader.should eql(loader.inverse.inverse)
  end

  it 'should convert attribute from params hash and vice versa' do
    transformer = Ducktrap::Attribute::ParamsHash.build(:foo) 

    input = { 'foo' => 'bar' }

    result = transformer.run(input)
    result.output.should eql(Ducktrap::NamedValue.new(:foo, 'bar'))

    transformer.inverse.run(result.output).output.should eql(input)
  end

  it 'should be equivalent from dsl and oo interface' do
    a = Ducktrap::Block.build do 
      attributes_hash_from_params_hash_extraction do
        attribute_from_params_hash(:foo) do
          primitive(String)
        end
        attribute_from_params_hash(:baz)
      end
    end

    foo = Ducktrap::Attribute::ParamsHash.new(:foo, Ducktrap::Block.new([Ducktrap::Primitive.new(String)]))
    baz = Ducktrap::Attribute::ParamsHash.new(:baz)

    b = Ducktrap::Block.new([Ducktrap::AttributesHash::ParamsHashExtraction.new([foo, baz])])

    a.should eql(b)
  end

  it 'should convert attributes via params hash extraction and vice versa' do
    transformer = Ducktrap::AttributesHash::ParamsHashExtraction.build do
      attribute_from_params_hash(:foo)
      attribute_from_params_hash(:baz)
    end

    input = { 'foo' => 'bar', 'baz' => 'fuz' }

    result = transformer.run(input)
    result.output.should eql(
      :foo => 'bar',
      :baz => 'fuz'
    )

    transformer.inverse.run(result.output).output.should eql(input)
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
    let(:input) { 'amount=1000&name=Markus+Schirp' }

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
    let(:input) { 'amount=10a0&name=Markus+Schirp' }

    it { should_not be_successful }

  end

  context 'when input is empty' do
    let(:input) { 'name=Markus+Schirp&amount=' }

    it { should_not be_successful }
  end

  context 'when input is missing attribute' do
    let(:input) { 'name=Markus+Schirp' }

    it { should_not be_successful }
  end

  context 'when input is in invalid format' do
    let(:input) { 'name[]=Markus+Schirp' }

    it { should_not be_successful }
  end
end
