# frozen_string_literal: true

Gem::Specification.new do |gem|
  gem.name        = 'morpher'
  gem.version     = '0.4.1'
  gem.authors     = ['Markus Schirp']
  gem.email       = 'mbj@schirp-dso.com'
  gem.description = 'Domain Transformation Algebra'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/mbj/morpher'

  gem.require_paths    = %w[lib]
  gem.files            = Dir.glob('lib/**/*')
  gem.extra_rdoc_files = %w[LICENSE]
  gem.license          = 'MIT'

  gem.required_ruby_version = '>= 2.5'

  gem.add_runtime_dependency('abstract_type', '~> 0.0.7')
  gem.add_runtime_dependency('adamantium',    '~> 0.2.0')
  gem.add_runtime_dependency('anima',         '~> 0.3.0')
  gem.add_runtime_dependency('concord',       '~> 0.1.5')
  gem.add_runtime_dependency('equalizer',     '~> 0.0.9')
  gem.add_runtime_dependency('mprelude',      '~> 0.1.0')
  gem.add_runtime_dependency('procto',        '~> 0.0.2')

  gem.add_development_dependency('mutant',       '~> 0.10')
  gem.add_development_dependency('mutant-rspec', '~> 0.10')
  gem.add_development_dependency('rspec',        '~> 3.10')
  gem.add_development_dependency('rspec-core',   '~> 3.10')
  gem.add_development_dependency('rspec-its',    '~> 1.3.0')
  gem.add_development_dependency('rubocop',      '~> 1.11')
end
