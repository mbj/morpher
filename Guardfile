# encoding: utf-8

guard :bundler do
  watch('Gemfile')
end

guard :rspec, :all_after_pass => false, :all_on_start => false, :cli => %w(--fail-fast) do
  # run all specs if the spec_helper or supporting files files are modified
  watch('spec/spec_helper.rb')                      { 'spec' }
  watch(%r{\Aspec/(?:lib|support|shared)/.+\.rb\z}) { 'spec' }

  watch(%r{lib/.*.rb})                              { 'spec' }

  # run a spec if it is modified
  watch(%r{\Aspec/.+_spec\.rb\z})
end
