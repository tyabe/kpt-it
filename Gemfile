source 'https://rubygems.org'

ruby "2.0.0"

# Project requirements
gem 'rake'
gem 'sinatra-flash', :require => 'sinatra/flash'

# Component requirements
gem 'bcrypt-ruby', :require => "bcrypt"
gem 'sass'
gem 'haml'
gem 'mini_record'

# Test requirements
gem 'rspec', :group => "test"
gem 'rack-test', :require => "rack/test", :group => "test"
gem "database_cleaner", "1.0.1", :group => "test"

# Padrino Stable Gem
gem 'padrino', '0.10.6'

gem 'thin'

group :production do
  gem 'pg'
end

group :development do
  gem 'sqlite3'
  gem 'pry-padrino'
  gem 'foreman'
end

gem 'heroku', :require => false
gem 'settingslogic'
gem 'pusher'
