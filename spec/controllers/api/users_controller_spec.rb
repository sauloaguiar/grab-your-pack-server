require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

  before {
    request.headers['Accept'] = 'application/vnd.grabyourpack'
  }

  def create_person(attrs = {})
    default_attrs = {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      phone: Faker::Number.number(10)
    }
    Person.create(default_attrs.merge(attrs))
  end

  describe "GET #show" do
    before do
      @user = create_person({:email => "sample@email.com"})
      get :show, id: @user.id, format: :json
    end

    it "returns the information about the user" do
      server_response = JSON.parse(response.body, symbolize_names: true)
      expect(server_response[:email]).to eq("sample@email.com")
      expect(response).to have_http_status(200)
    end
  end


end
