require 'rails_helper'

RSpec.describe Api::UsersController, type: :controller do

  before {
    request.headers['Accept'] = 'application/vnd.grabyourpack'
    key = ApiKey.create!(:access_token => "token")
    request.headers['Authorization'] = "Bearer #{key.access_token}"
  }

  describe "GET #show" do
    before do
      @user = create_person({:email => "sample@email.com"})
      get :show, id: @user.id, format: :json
    end

    it "returns the information about the user" do
      server_response = json_response
      expect(response).to have_http_status(200)
      expect(server_response[:user][:email]).to eq("sample@email.com")
    end
  end

  describe "POST #create" do
    context "when the user is succesfully created" do
      let(:user_data) {{
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet::email,
        phone: Faker::Number.number(10)
        }}
      before do
        post :create, { user: user_data }, format: :json
      end

      it "returns the json of the newly created record" do
        server_response = json_response
        expect(response).to have_http_status(201)
        expect(server_response[:user][:email]).to eq(user_data[:email])
      end
    end

    context "when the user is not created" do
      before do
        @user = create_person({:email => nil}).attributes
        post :create, { user: @user }, format: :json
      end

      it "returns a json containing an errors key" do
        server_response = json_response
        expect(response).to have_http_status(422)
        expect(server_response).to include(:errors)
      end

      it "returns an explanation on why the user was not created" do
        server_response = json_response
        expect(response).to have_http_status(422)
        expect(server_response[:errors][:email]).to include("can't be blank")
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
        server_response = json_response
        expect(response).to have_http_status(200)
        expect(server_response[:user][:email]).to eq("name@email.com")
      end
    end

    context "when it is not updated" do
      before do
        @user = create_person
        patch :update, { id: @user.id, user: { email: "" } }, format: :json
      end

      it "returns a json containing an errors key" do
        server_response = json_response
        expect(response).to have_http_status(422)
        expect(server_response).to include(:errors)
      end

      it "has an explanation on why the user wasn't updated" do
        server_response = json_response
        expect(response).to have_http_status(422)
        expect(server_response[:errors][:email]).to include("can't be blank")
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

  describe "GET #search" do
    context "" do
      before do

      end
    end

  end

end
