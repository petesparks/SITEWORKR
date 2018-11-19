class AddConversationsToMatches < ActiveRecord::Migration[5.2]
  def change
    add_reference :matches, :conversation, index: true
  end
end

