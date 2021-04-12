class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  def authenticate
    if user = authenticate_with_http_basic { |username, password| User.authenticate(username, password) }
      @current_user = user
    else
      request_http_basic_authentication
    end
  end
end
