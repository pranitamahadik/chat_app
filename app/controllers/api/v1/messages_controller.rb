class Api::V1::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!
  before_action :find_chat_room, only: [:create]

  # POST /api/v1/chat_rooms/:chat_room_id/messages
  def create
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

  def find_chat_room
    @chat_room = ChatRoom.find_by(id: params[:chat_room_id])
    render(json: { error: 'Chat room not found' }, status: :not_found) && return if @chat_room.blank?
  end
end
