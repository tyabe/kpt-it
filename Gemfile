source 'https://rubygems.org'

ruby "2.1.0"

# Project requirements
gem 'rake'

# Component requirements
gem 'slim'
gem 'bcrypt-ruby', :require => "bcrypt"
gem 'sass'
gem 'activerecord', '>= 3.1', :require => 'active_record'
gem 'mini_record'

# Test requirements
group :test do
  gem 'rspec'
  gem 'rack-test', :require => "rack/test"
  gem "database_cleaner", "1.0.1"
end

# Padrino Stable Gem
gem 'padrino', '0.12.0'

gem 'unicorn'

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

group :development, :test do
  gem 'coveralls', :require => false
end
