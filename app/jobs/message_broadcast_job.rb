class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast("chat_room_#{message.chat_room_id}_channel", {message: render_message(message)})
   rescue => e
  	Rails.logger.error("Failed to broadcast message: #{e.message}")
  	Rails.logger.error(e.backtrace.join("\n"))
  end

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'api/v1/messages/message', locals: { message: message })
  end
end
