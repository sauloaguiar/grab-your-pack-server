class Api::BuildingsController < ApplicationController

  def create
    @building_apartment_form = BuildingApartmentForm.new(request_params)
    if @building_apartment_form.save
      render json: @building_apartment_form.building, status: 201
    else
      render json: { errors: @building_apartment_form.errors }, status: 422
    end
  end

  def update
    building = Building.find(params[:id])
    if building.update(request_params)
      render json: building, status: 200, location: [:api, building]
    else
      render json: { errors: building.errors }, status: 422
    end
  end

  def destroy
    Building.find(params[:id]).destroy
    head 204
  end

  def show
    respond_to do |format|
      format.any(:json) { render request.format.to_sym => Building.find(params[:id]) }
    end
  end

  def by_address
    building = Building.find_by(
        address_1: building_search_params[:address_1],
        address_2: building_search_params[:address_2],
        city: building_search_params[:city],
        state: building_search_params[:state],
        country: building_search_params[:country],
        zip_code: building_search_params[:zip_code])
    if building
      render json: { building: building }, status: 200
    else
      render json: { errors: "building address #{params[:address_1]} not found" } , status: 404
    end
  end

  private
  def building_search_params
    params.permit(:address_1, :address_2, :city, :state, :country, :zip_code)
  end
  def request_params
    params.require(:building).permit(:address_1, :address_2, :city, :state, :country, :zip_code, apartments: [:unit])
  end
end
