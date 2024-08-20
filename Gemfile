# frozen_string_literal: true

source 'https://rubygems.org'

gem 'bootsnap', require: false
gem 'high_voltage'
gem 'importmap-rails'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.2.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails'
gem 'turbo-rails'

# not default
gem 'slim'
gem 'slim-rails'

group :development, :test do
  gem 'brakeman', require: false
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console'

  # not default
  gem 'rubocop-capybara', require: false
  gem 'rubocop-fjord', require: false
  gem 'rubocop-rails', require: false
  gem 'slim_lint'
end

group :test do
  # not default
  gem 'capybara'
  gem 'simplecov', require: false
  gem 'webdrivers'
end
