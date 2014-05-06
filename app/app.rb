module KptIt
  class App < Padrino::Application
    register ScssInitializer
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers

    set :sessions, key: '_kpt_it_session'

    unless Padrino.env == :production
      ::Pusher.app_id = ENV['PUSHER_APP_ID']  || Setting.pusher.app_id
      ::Pusher.key    = ENV['PUSHER_KEY']     || Setting.pusher.key
      ::Pusher.secret = ENV['PUSHER_SECRET']  || Setting.pusher.secret
    end

    get '/' do
      render :index
    end

    error 404 do
      render :not_found
    end

    error ActiveRecord::RecordNotFound do
      render :not_found
    end

    error Sinatra::NotFound do
      render :not_found
    end

  end
end
