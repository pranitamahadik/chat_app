class OnlineStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "online_status_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
