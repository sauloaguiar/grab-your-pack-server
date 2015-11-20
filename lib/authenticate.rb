#require 'api_key'

class Authenticate
  # Authenticates token on the form of
  # "Bearer <api-key>"
  def self.valid?(request)
    auth = request.headers['Authorization']
    if auth
      api_key = auth.split(' ').last
      ApiKey.exists?(access_token: api_key)
    end
  end
end
