RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

ActiveRecord::Base.logger = Padrino.logger

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  require 'database_cleaner'
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

def session
  last_request.env['rack.session']
end

def flash
  _flash_1 = last_request.env['rack.session.unpacked_cookie_data']['_flash'] || {}
  _flash_2 = last_request.env['rack.session']['_flash'] || {}
  _flash_1.merge(_flash_2)
end

def request_to(verb, path, _params = {})
  csrf_token = SecureRandom.hex(32)
  _session = _params[:session] || {}
  unless %w[GET HEAD OPTIONS TRACE].include? verb.to_s.upcase
    _session.merge!(csrf: csrf_token)
    _params.merge!(authenticity_token: csrf_token)
  end
  if defined?(remote) && remote
    __send__(verb.to_s.downcase, path, _params, 'rack.session' => _session, "HTTP_X_REQUESTED_WITH" => "XMLHttpRequest")
  else
    __send__(verb.to_s.downcase, path, _params, 'rack.session' => _session)
  end
end
