class Api::BuildingsController < ApplicationController
  #respond_to :json

  def create
    building = Building.new(request_params)
    if building.save
      render json: building, status: 201, location: [:api, building]
    else
      render json: { errors: building.errors }, status: 422
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
      params.require(:building).permit(:address_1, :address_2, :city, :state, :country, :zip_code)
    end
end
