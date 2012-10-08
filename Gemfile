source 'https://rubygems.org'

gemspec

gem 'aequitas',            :git => 'https://github.com/mbj/aequitas.git'
gem 'abstract_class',      :git => 'https://github.com/dkubb/abstract_class.git'
gem 'immutable',           :git => 'https://github.com/dkubb/immutable.git', :branch => :experimental
gem 'descendants_tracker', :git => 'https://github.com/dkubb/descendants_tracker.git'
gem 'equalizer',           :git => 'https://github.com/dkubb/equalizer.git'
gem 'anima',               :git => 'https://github.com/mbj/anima.git'
gem 'i18n'
gem 'rack'

group :development do
  gem 'rake'
  gem 'shotgun'
  gem 'rspec',  '~> 2.11'
end

group :metrics do
  gem 'fattr',       '~> 2.2.0'
  gem 'arrayfields', '~> 4.7.4'
  gem 'flay',        '~> 1.4.2'
  gem 'flog',        '~> 2.5.1'
  gem 'map',         '~> 6.2.0'
  gem 'reek',        '~> 1.2.8', :git => 'https://github.com/dkubb/reek.git'
  gem 'roodi',       '~> 2.1.0'
  gem 'yardstick',   '~> 0.6.0'
  gem 'heckle',      '~> 2.0.0.b1'

  platforms :rbx do
    gem 'pelusa', :git => 'https://github.com/codegram/pelusa.git'
  end
end

group :guard do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'rb-inotify', :git => 'https://github.com/mbj/rb-inotify'
end

