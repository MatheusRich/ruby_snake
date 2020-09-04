# frozen_string_literal: true

source 'https://rubygems.org'

gem 'rich_engine', git: 'https://github.com/MatheusRich/rich_engine', branch: 'master'

gemspec

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-minitest', require: false
  gem 'solargraph'
end

group :test do
  gem 'guard'
  gem 'guard-minitest', require: false
  gem 'minitest'
  gem 'minitest-reporters'
  gem 'rake'
  gem 'simplecov', require: false
end
