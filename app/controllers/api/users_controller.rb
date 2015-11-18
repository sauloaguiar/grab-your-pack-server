class Api::UsersController < ApplicationController


  def show
    respond_to do |format|
      format.any(:json) { render request.format.to_sym => Person.find(params[:id]) }
    end
  end

  #private


end
