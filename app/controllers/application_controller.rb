require 'authenticate'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

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
    authentication_token = request.headers['HTTP_AUTHORIZATION']
    Authenticate.valid?(authentication_token)
  end
end
