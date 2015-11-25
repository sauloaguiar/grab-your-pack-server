#require 'api_key'

class Authenticate
  # Authenticates token on the form of
  # "Bearer <api-key>"
  def self.valid?(authentication_token)
    if authentication_token
      api_key = authentication_token.split(' ').last
      ApiKey.exists?(access_token: api_key)
    end
  end
end
