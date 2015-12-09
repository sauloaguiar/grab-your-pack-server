#require_relative '../../forms/'
class Api::BuildingsController < ApplicationController
  #respond_to :json

  # def create
  #   building = Building.new(request_params)
  #   p request_params
  #   if building.save
  #     render json: building, status: 201, location: [:api, building]
  #   else
  #     p building.errors
  #     render json: { errors: building.errors }, status: 422
  #   end
  # end

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

  private
    def request_params
      params.require(:building).permit(:address_1, :address_2, :city, :state, :country, :zip_code, apartments: [:unit])
    end
end
