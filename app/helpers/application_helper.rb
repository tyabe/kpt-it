# Helper methods defined here can be accessed in any controller or view in the application

KptIt.helpers do
  def alert_message(name)
    "alert-message " <<
      case name.to_sym
      when :notice
        "info"
      when :alert
        "error"
      else
        name.to_s
      end
  end

end
