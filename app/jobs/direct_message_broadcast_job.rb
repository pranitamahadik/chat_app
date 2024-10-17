class DirectMessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(direct_message)
    ActionCable.server.broadcast "user_#{direct_message.receiver_id}_channel", message: render_message(direct_message)
  end

  private

  def render_message(direct_message)
    ApplicationController.renderer.render(partial: 'direct_messages/message', locals: { direct_message: direct_message })
  end
end
