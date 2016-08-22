# frozen_string_literal: true
source 'https://rubygems.org'

ruby '2.3.1'

gem 'rails', '~> 4.2.6'
gem 'bluecloth'
gem 'aws-sdk', '<2.0'
gem 'haml'
gem 'rails_admin'
gem 'devise'
gem 'jbuilder'
gem 'kaminari'
gem 'geocoder'
gem 'jquery-rails'
gem 'pg'

group :development do
  gem 'bullet'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'coveralls', require: false
  gem 'brakeman', require: false
  gem 'rubocop', require: false
  gem 'bundler-audit', require: false
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'therubyracer', platform: 'ruby'
  gem 'uglifier'
end

group :production do
  gem 'passenger'
end
