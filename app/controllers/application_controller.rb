class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  # before_action :authenticate
  #
  # protected
  #   def authenticate
  #     restrict_access || render_unauthorized
  #   end
  #
  #   def render_unauthorized
  #     self.headers['WWW-Authenticate'] = 'Token realm="Application"'
  #     render json: 'Bad Credentials', status: 401
  #   end
  #
  #   def restrict_access
  #     p headers
  #     p params
  #     authenticate_with_http_token do |token, options|
  #       ApiKey.exists?(access_token: token)
  #     end
  #   end
end
