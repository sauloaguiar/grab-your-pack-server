require 'rails_helper'

RSpec.describe Api::NotificationsController, type: :controller do
  before { request.headers['Accept'] = 'application/vnd.grabyourpack'
    key = ApiKey.create!(:access_token => "token")
    request.headers['Authorization'] = "Bearer #{key.access_token}"
  }

  describe "GET " do

  end
end
