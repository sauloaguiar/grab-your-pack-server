class Api::UsersController < ApplicationController

  def create
    user = Person.create(person_params)
    if user.save
      render json: user, status: 201, location: api_users_url(user)
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def update
    user = Person.find(params[:id])
    if user.update(person_params)
      render json: user, status: 200, location: api_users_url(user)
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = Person.find(params[:id])
    user.destroy

    head 204
  end

  def show
    respond_to do |format|
      format.any(:json) { render request.format.to_sym => Person.find(params[:id]) }
    end
  end

  private
    def person_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone)
    end
end
