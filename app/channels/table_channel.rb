class TableChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    table = Table.find(params[:id])
    stream_for table
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
