# -*- encoding: utf-8 -*-

require File.expand_path('../lib/ducktrap/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'ducktrap'
  gem.version     = Ducktrap::VERSION.dup
  gem.authors     = [ 'Markus Schirp' ]
  gem.email       = [ 'mbj@seonic.net' ]
  gem.description = 'Invertible data filter/mutator on data structures'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/mbj/ducktrap'

  gem.require_paths    = [ 'lib' ]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- spec`.split("\n")
  gem.extra_rdoc_files = %w[TODO]

  gem.add_runtime_dependency('backports',     '~> 2.6.4')
  gem.add_runtime_dependency('adamantium',    '~> 0.0.3')
  gem.add_runtime_dependency('equalizer',     '~> 0.0.1')
  gem.add_runtime_dependency('abstract_type', '~> 0.0.2')
  gem.add_runtime_dependency('addressable',   '~> 2.3.2')
  gem.add_runtime_dependency('anima',         '~> 0.0.1')
end
