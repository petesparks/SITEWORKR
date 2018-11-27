class Message < ApplicationRecord
  belongs_to :match
  belongs_to :user
  after_create :broadcast_message
  validates_presence_of :body, :match_id, :user_id
  def message_time
   created_at.strftime("%m/%d/%y at %l:%M %p")
  end

  def broadcast_message
    ActionCable.server.broadcast("match_#{match.id}", {
      message_partial: ApplicationController.renderer.render(
        partial: "messages/other_message",
        locals: { message: self, user_is_messages_author: false }
      ),
      current_user_id: user.id
    })
  end
end
