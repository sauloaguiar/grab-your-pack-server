class Api::NotificationsController < ApplicationController
  def index
    apartment = Apartment.where(id: params[:apartment_id]).first
    if apartment
      list = get_notification_list(apartment.notifications)
      render json: { apartments: list }, status: 200
    else
      render json: { message: "Apartment #{params[:apartment_id]} not found" }, status: 404
    end
  end

  def get_notification_list(notifications)
    notifications.group_by { |date| date.created_at.to_date }
  end
end
