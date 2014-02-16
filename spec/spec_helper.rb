require 'database_cleaner'

RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

ActiveRecord::Base.logger = Padrino.logger

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  conf.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  conf.before(:each) do
    DatabaseCleaner.start
  end

  conf.after(:each) do
    DatabaseCleaner.clean
  end
end

def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end

module ::ActiveModel::Validations
  def errors_on(attribute, options = {})
    valid_args = [options[:context]].compact
    self.valid?(*valid_args)

    [self.errors[attribute]].flatten.compact
  end
  alias :error_on :errors_on
end
