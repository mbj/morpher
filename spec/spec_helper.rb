$: << 'lib'

require 'pp'
require 'ducktrap'

# require spec support files and shared behavior
Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each { |f| require f }

require 'rspec/autorun'

RSpec.configure do |config|
  config.extend(LetMockHelper)
  config.include(HTMLHelper)
end
