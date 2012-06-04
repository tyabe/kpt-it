class Setting < Settingslogic
  config_file = "#{Padrino.root}/config/application.yml"
  default_config_file = "#{Padrino.root}/config/application.default.yml"
  source File.exist?(config_file) ? config_file : default_config_file
  namespace Padrino.env.to_s
  load!
end
