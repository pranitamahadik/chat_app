class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  validates :content, presence: true


  def sender
    self.user
  end
end
