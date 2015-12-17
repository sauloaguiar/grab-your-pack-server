require 'rails_helper'

describe Api::BuildingsController, type: :controller do
  before { request.headers['Accept'] = 'application/vnd.grabyourpack'
    key = ApiKey.create!(:access_token => "token")
    request.headers['Authorization'] = "Bearer #{key.access_token}"
  }

  describe "GET #show" do
    before(:each) do
      @building = create_building
      get :show, id: @building.id, format: :json
    end

    it "returns the information on a hash" do
      server_response = json_response
      expect(response).to have_http_status(200)
      expect(server_response[:building][:address_1]).to eq(@building.address_1)
    end
  end

  describe "POST #create" do
    context "for a valid building object" do
      let(:building_data) {{
        address_1: Faker::Address.street_address,
        address_2: Faker::Address.secondary_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        country: Faker::Address.country_code,
        zip_code: Faker::Address.zip
      }}
      before do
        post :create, { building: building_data }, format: :json
      end

      it "returns the json representation for the newly created record" do
        server_response = json_response
        expect(response).to have_http_status(201)
        expect(server_response[:building][:address_1]).to eq(building_data[:address_1])
      end
    end

    context "for an invalid building object" do
      before do
        @building = create_building(address_1:nil).attributes
        post :create, { building: @building }, format: :json
      end

      it "returns a error json notification" do
        server_response = json_response
        expect(response).to have_http_status(422)
        expect(server_response).to include(:errors)
      end

      it "returns an error explanation on why the building wasn't created" do
        server_response = json_response
        expect(response).to have_http_status(422)
        expect(server_response[:errors][:address_1]).to include("can't be blank")
      end
    end

    context "for a valid building containing apartments" do
      let(:apartment_data) {{
          unit: Faker::Address.building_number
      }}
      let(:building_data) {{
          address_1: Faker::Address.street_address,
          address_2: Faker::Address.secondary_address,
          city: Faker::Address.city,
          state: Faker::Address.state,
          country: Faker::Address.country_code,
          zip_code: Faker::Address.zip,
          apartments: [
            apartment_data
          ]
      }}
      before do
        post :create, { building: building_data }, format: :json
      end
      it "returns a building object containing the apartment" do
        server_response = json_response
        expect(response).to have_http_status(201)
        expect(server_response[:building][:address_1]).to eq(building_data[:address_1])
        expect(server_response[:building][:apartments][0][:unit]).to eq(apartment_data[:unit])
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
        server_response = json_response
        expect(response).to have_http_status(200)
        expect(server_response[:building][:address_1]).to eq("5th Av")
      end
    end

    context "when it is not updated" do
      before do
        building = create_building
        patch :update, { id: building.id, building: { address_1: nil }}, format: :json
      end

      it "returns an error on json" do
        server_response = json_response
        expect(response).to have_http_status(422)
        expect(server_response).to include(:errors)
      end

      it "returns an error explanation why the building was not updated" do
        server_response = json_response
        expect(response).to have_http_status(422)
        expect(server_response[:errors][:address_1]).to include "can't be blank"
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

  describe "GET #by_address" do
    context "for an existing address" do
      before do
        @building = create_building
        get :by_address,
          {
            building: {
              address_1: @building.address_1,
              address_2: @building.address_2,
              city: @building.city,
              state: @building.state,
              country: @building.country,
              zip_code: @building.zip_code
            }
          },
          format: :json
      end

      it "returns the information on a json" do
        server_response = json_response
        expect(response).to have_http_status(200)
        expect(server_response[:building][:address_1]).to eq(@building.address_1)
      end
    end

    context "for an inexisting address" do
      before do
        @building_attrs = {
          address_1: Faker::Address.street_address,
          address_2: Faker::Address.secondary_address,
          city: Faker::Address.city,
          state: Faker::Address.state,
          country: Faker::Address.country_code,
          zip_code: Faker::Address.zip
        }
        get :by_address, { building: @building_attrs }, format: :json
      end
      it "returns an error message" do
        server_response = json_response
        expect(response).to have_http_status(404)
        expect(server_response[:errors]).to include("building address #{@building_attrs[:address_1]} not found")
      end
    end
  end
end
