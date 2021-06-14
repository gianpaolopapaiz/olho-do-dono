class RestaurantChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    restaurant = Restaurant.find(params[:id])
    stream_for restaurant
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
