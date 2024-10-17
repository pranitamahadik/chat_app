class Api::V1::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  # POST /api/v1/chat_rooms/:chat_room_id/messages
  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @message = @chat_room.messages.build(message_params)
    @message.user = current_user

    if @message.save
      MessageBroadcastJob.perform_later(@message)
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
