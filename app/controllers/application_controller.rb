require 'authenticate'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :authenticate

  protected

  def authenticate
    restrict_access || render_unauthorized
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: { error: 'Bad Credentials' }, status: 401
  end

  def restrict_access
    #require 'pry'; binding.pry;
    #p request.headers
    Authenticate.valid?(request)
    # auth = request.headers['HTTP_AUTHORIZATION']
    # # "Token token=<api-key>"
    # authenticate_with_http_token do |token, options|
    #   ApiKey.exists?(access_token: token)
    # end
    # if auth
    #   api_key = auth.split(' ').last
    #   ApiKey.exists?(access_token: api_key)
    # end
  end
end
