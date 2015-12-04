class Api::NotificationsController < ApplicationController
  def index
    apartment = Apartment.where(id: params[:apartment_id]).first
    if apartment
      list = get_notification_list(apartment.notifications)
      render json: { notifications: list }, status: 200
    else
      render json: { message: "Apartment #{params[:apartment_id]} not found" }, status: 404
    end
  end

  def create
    notification = Notification.create(request_params)
    if notification.save
      render json: notification, status: 201, location: api_notifications_url(notification)
    else
      render json: { errors: notification.errors }, status: 422
    end
  end

  private
  def get_notification_list(notifications)
    notifications.group_by { |date| date.created_at.to_date }
  end

  def request_params
    params.require(:notification).permit(:person_id, :apartment_id, :notification_type)
  end
end
