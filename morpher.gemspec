# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name        = 'morpher'
  gem.version     = '0.0.1'
  gem.authors     = ['Markus Schirp']
  gem.email       = ['mbj@schirp-dso.com']
  gem.description = 'Composeable predicates on POROs'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/mbj/predicate'
  gem.license     = 'MIT'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split("\n")
  gem.test_files       = `git ls-files -- spec/{unit,integration}`.split("\n")
  gem.extra_rdoc_files = %w[TODO LICENSE]
  gem.executables      = %w[mutant]

  gem.add_runtime_dependency('abstract_type', '~> 0.0.7')
  gem.add_runtime_dependency('ast',           '~> 1.1.0')
  gem.add_runtime_dependency('adamantium',    '~> 0.1.0')
  gem.add_runtime_dependency('equalizer',     '~> 0.0.7')
  gem.add_runtime_dependency('anima',         '~> 0.1.1')
  gem.add_runtime_dependency('concord',       '~> 0.1.4')

  gem.add_development_dependency('triage', '~> 0.2')
end
