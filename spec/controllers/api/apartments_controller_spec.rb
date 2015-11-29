require 'rails_helper'

RSpec.describe Api::ApartmentsController, type: :controller do
  before { request.headers['Accept'] = 'application/vnd.grabyourpack'
    key = ApiKey.create!(:access_token => "token")
    request.headers['Authorization'] = "Bearer #{key.access_token}"
  }

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

  def create_apartment(attrs={})
    default_attrs = {
      unit: Faker::Address.building_number,
      building: create_building
    }
    Apartment.create!(default_attrs.merge(attrs))
  end

  describe "GET #show" do
    before(:each) do
      @apartment = create_apartment
      get :show, id: @apartment.id, format: :json
    end

    it "returns the information on a hash" do
      server_response = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(200)
      expect(server_response[:apartment][:unit]).to eq(@apartment.unit)
    end
  end

  describe "POST #create" do
    context "for a valid apartment entry" do
      let(:apartment_data) {{
        unit: Faker::Address.building_number,
        building_id: create_building[:id]
        }}
      before do
        post :create, {apartment: apartment_data}, format: :json
      end
      it "returns the json representation of the newly created record" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(201)
        expect(server_response[:apartment][:unit]).to eq(apartment_data[:unit])
        expect(server_response[:apartment][:building_id]).to eq(apartment_data[:building_id])
      end
    end

    context "for an invalid apartment entry" do
      let(:apartment_data){{
        unit: nil,
        builing_id: create_building[:id]
        }}
      before do
        post :create, { apartment: apartment_data}, format: :json
      end
      it "returns an error json notification" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(422)
        expect(server_response).to include(:errors)
      end
      it "returns an error explanation on why it wasn't created" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(422)
        expect(server_response[:errors][:unit]).to include("can't be blank")
      end
    end
  end

  describe "PUT/PATCH #update" do
    context "when it is succesfully updated" do
      before do
        apartment = create_apartment
        post :update, { id: apartment.id, apartment:{unit: "255"} }, format: :json
      end
      it "return the succesfully updated apartment" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(server_response[:apartment][:unit]).to eq("255")
      end
    end

    context "when it's not updated" do
      before do
        apartment = create_apartment
        post :update, { id: apartment.id, apartment:{unit: nil} }, format: :json
      end
      it "returns a json with error" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(422)
        expect(server_response).to include(:errors)
      end
      it "returns an error explanation why the apartment was not updated" do
        server_response = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(422)
        expect(server_response[:errors][:unit]).to include("can't be blank")
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      apartment = create_apartment
      delete :destroy, { id: apartment.id }, format: :json
    end

    it "should answer with 204" do
      expect(response).to have_http_status(204)
    end
  end
end
