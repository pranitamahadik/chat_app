class Api::V1::DirectMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  # GET /api/v1/direct_messages
  def index
    @direct_messages = DirectMessage.where(sender: current_user).or(DirectMessage.where(receiver: current_user))
    render json: @direct_messages
  end

  # POST /api/v1/direct_messages
  def create
    @direct_message = DirectMessage.new(direct_message_params)
    @direct_message.sender = current_user

    if @direct_message.save
      DirectMessageBroadcastJob.perform_later(@direct_message)
      render json: @direct_message, status: :created
    else
      render json: @direct_message.errors, status: :unprocessable_entity
    end
  end

  private

  def direct_message_params
    params.require(:direct_message).permit(:receiver_id, :content)
  end
end
