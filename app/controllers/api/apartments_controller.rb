class Api::ApartmentsController < ApplicationController

  def create
    apartment = Apartment.new(request_params)
    if apartment.save
      render json: apartment, serializer: ApartmentSerializer, status: 201, location: [:api, apartment]
    else
      render json: { errors: apartment.errors }, status: 422
    end
  end

  def update
    apartment = Apartment.find(params[:id])
    if apartment.update(request_params)
      render json: apartment, serializer: ApartmentSerializer, status: 200, location: [:api, apartment]
    else
      render json: { errors: apartment.errors }, status: 422
    end
  end

  def destroy
    Apartment.find(params[:id]).destroy
    head 204
  end

  def show
    respond_to do |format|
      format.any(:json) { render request.format.to_sym => Apartment.find(params[:id]) }
    end
  end

  private
    def request_params
      params.require(:apartment).permit(:unit, :building_id)
    end
end
