require 'rails_helper'

describe Api::BuildingsController, type: :controller do
  before { request.headers['Accept'] = 'application/vnd.grabyourpack' }

  def create_building(attrs = {})
    default_attrs = {
      address_1: Faker::Address.street_address,
      address_2: Faker::Address.secondary_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      country: Faker::Address.country_code,
      zip_code: Faker::Address.zip
    }
    Building.create(default_attrs.merge(attrs))
  end

  describe "GET #show" do
    before(:each) do
      @building = create_building
      get :show, id: @building.id, format: :json
    end

    it "returns the information on a hash" do
      server_response = JSON.parse(response.body, symbolize_names: true)
      expect(server_response[:building][:address_1]).to eq(@building.address_1)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "for a valid building object" do
      before do
        @building = create_building.attributes
        post :create, { building: @building }, format: :json
      end

      it "returns the json representation for the newly created record" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(server_response[:building][:address_1]).to eq(@building["address_1"])
        expect(response).to have_http_status(201)
      end
    end

    context "for an invalid building object" do
      before do
        @building = create_building(address_1:nil).attributes
        post :create, { building: @building }, format: :json
      end

      it "returns a error json notification" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(server_response).to include(:errors)
        expect(response).to have_http_status(422)
      end

      it "returns an error explanation on why the building wasn't created" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(server_response[:errors][:address_1]).to include("can't be blank")
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "PUT/PATCH #update" do
    context "when it is succesfully updated" do
      before do
        building = create_building
        patch :update, { id: building.id, building: { address_1: "5th Av" } }, format: :json
      end
      it "returns the json representation for the updated user" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(server_response[:building][:address_1]).to eq("5th Av")
        expect(response).to have_http_status(200)
      end
    end

    context "when it is not updated" do
      before do
        building = create_building
        patch :update, { id: building.id, building: { address_1: nil }}, format: :json
      end

      it "returns an error on json" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(server_response).to include(:errors)
        expect(response).to have_http_status(422)
      end

      it "returns an error explanation why the building was not updated" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(server_response[:errors][:address_1]).to include "can't be blank"
        expect(response).to have_http_status(422)
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      building = create_building
      delete :destroy, { id: building.id }, format: :json
    end

    it "should answer with 204" do
      expect(response).to have_http_status(204)
    end
  end
end
