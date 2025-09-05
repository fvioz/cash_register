# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.4.4'

# Core
gem 'bootsnap', '~> 1.18', require: false
gem 'sorbet-static-and-runtime', '~> 0.6.12479'
gem 'zeitwerk', '~> 2.7'

group :development do
  gem 'ruby-lsp-rspec', require: false
  gem 'ruby_parser', '~> 3.21'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'debug', platforms: %i[mri], require: 'debug/prelude'
  gem 'packs'
  gem 'rspec', '~> 3.13'
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rspec', '~> 3.7'
  gem 'tapioca', require: false
end

group :test do
  gem 'simplecov', require: false
end
