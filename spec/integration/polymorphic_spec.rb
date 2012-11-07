require 'spec_helper'

describe 'polymorphic mapping' do
  let(:model_a) { Class.new { def self.name; 'A'; end } }
  let(:model_b) { Class.new { def self.name; 'B'; end } }

  let(:dumper) do
    map_a = Ducktrap::Static.new('a', 'ia')
    map_b = Ducktrap::Static.new('b', 'ib')

    loaders = [
      Ducktrap::Polymorphic::Type::Dumper.new('a', model_a, map_a),
      Ducktrap::Polymorphic::Type::Dumper.new('b', model_b, map_b)
    ]

    Ducktrap::Block.new(
      [
        Ducktrap::Polymorphic::Map::Dumper.new(loaders)
      ]
    )
  end

  let(:loader) { dumper.inverse }

  it 'should map correctly' do
    dumper.run(model_a.new).output.should eql('type' => 'a', 'body' => 'a')
  end

  it 'should load correctly' do
    loader.run('type' => 'a', 'body' => 'a').output.should eql('ia')
  end
end
