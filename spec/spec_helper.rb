require 'morpher'

module PreludeHelper
  def right(value)
    Morpher::Either::Right.new(value)
  end

  def left(value)
    Morpher::Either::Left.new(value)
  end
end

RSpec.configure do |config|
  config.include(PreludeHelper)
end
