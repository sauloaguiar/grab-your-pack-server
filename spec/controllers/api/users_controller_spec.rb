require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

  before {
    request.headers['Accept'] = 'application/vnd.grabyourpack'
    #key = ApiKey.create!(:access_token => "token")
    #request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials("token")
    #p request
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
      expect(server_response[:user][:email]).to eq("sample@email.com")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "when the user is succesfully created" do
      before do
        @user = create_person.attributes
        @user['email'] = Faker::Internet.email
        post :create, { user: @user }, format: :json
      end

      it "returns the json of the newly created record" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(server_response[:user][:email]).to eq(@user['email'])
        expect(response).to have_http_status(201)
      end
    end

    context "when the user is not created" do
      before do
        @user = create_person({:email => nil}).attributes
        post :create, { user: @user}, format: :json
      end

      it "returns a json containing an errors key" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(server_response).to include(:errors)
        expect(response).to have_http_status(422)
      end

      it "returns an explanation on why the user was not created" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(server_response[:errors][:email]).to include("can't be blank")
        expect(response).to have_http_status(422)
      end

    end
  end

  describe "PUT/PATCH #update" do
    context "when it is succesfully updated" do
      before do
        @user = create_person
        patch :update, { id: @user.id, user: { email: "name@email.com" } }, format: :json
      end

      it "returns the json representation of the updated user" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(server_response[:user][:email]).to eq("name@email.com")
        expect(response).to have_http_status(200)
      end
    end

    context "when it is not updated" do
      before do
        @user = create_person
        patch :update, { id: @user.id, user: { email: "" } }, format: :json
      end

      it "returns a json containing an errors key" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(server_response).to include(:errors)
        expect(response).to have_http_status(422)
      end

      it "has an explanation on why the user wasn't updated" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(server_response[:errors][:email]).to include("can't be blank")
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @user = create_person
      delete :destroy, { id: @user.id }, format: :json
    end

    it "should answer with a 204" do
      expect(response).to have_http_status(204)
    end
  end

end
