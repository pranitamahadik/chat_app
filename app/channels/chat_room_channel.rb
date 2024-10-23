class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    # Stream from the specific chat room channel
    stream_from "chat_room_#{params[:chat_room_id]}_channel"
    Rails.logger.info "User subscribed to chat_room_#{params[:chat_room_id]}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
