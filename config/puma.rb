workers Integer(ENV['PUMA_WORKERS'] || 3)
threads Integer(ENV['MIN_THREADS']  || 1), Integer(ENV['MAX_THREADS'] || 16)

app_env = ENV['RACK_ENV'] || 'development'

rackup          DefaultRackup
environment     app_env
worker_timeout  15

prune_bundler

preload_app!

on_worker_boot do
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
end

after_worker_boot do
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[app_env.to_sym])
end
