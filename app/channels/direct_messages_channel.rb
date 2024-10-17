class DirectMessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_#{current_user.id}_channel"
  end

  def unsubscribed
    stop_all_streams
  end
end
