require 'spec_helper'

describe 'simple ducktrap' do
  subject { loader.run(input) }

  let(:model) do
    Class.new do
      include Adamantium, Anima

      attribute :name
      attribute :amount

      include Equalizer.new(*attribute_set.map(&:name))
    end
  end


  let(:loader) do
    model = self.model

    Ducktrap::Block.build do 
      params_hash_from_url_encoded_string
      attributes_hash_from_params_hash do 
        attribute_from_params(:name) do
          primitive(String)
        end

        attribute_from_params(:amount) do
          primitive(String)
        end
      end
      anima_from_attributes_hash(model)
    end
  end

  let(:dumper) do
    loader.inverse
  end

  context 'when input is fully loadable' do
    let(:input) { 'name=Markus+Schirp&amount=1000' }

    it 'should not result in an error' do
      puts
      loader.pretty_dump
      unless subject.successful?
        puts
        subject.output.pretty_dump
        fail 'ducktrap is not successful'
      end
    end

    its(:result) { should eql(model.new(:name => 'Markus Schirp', :amount => '1000')) }

    it 'allows to round trip' do
      dumper.run(subject.result).should eql(input)
    end
  end

  context 'with invalid integer' do
    let(:input) { 'name=Markus+Schirp&amount=10a0' }

    it { should_not be_successful }

  end

  pending 'when input is empty' do
    let(:input) { 'name=Markus+Schirp&amount=' }

    it { should be_successful }

    its(:result) { should eql(model.new(:name => 'Markus Schirp', :amount => nil)) }
  end

  context 'when input is missing attribute' do
    let(:input) { 'name=Markus+Schirp' }

    it { should be_successful }
    its(:result) { should eql(model.new(:name => 'Markus Schirp', :amount => nil)) }
  end

  pending 'when input is in invalid format' do
    let(:input) { 'name[]=Markus+Schirp' }

    it { should_not be_successful }
    its(:result) { should be(Ducktrap::Undefined) }
  end
end
