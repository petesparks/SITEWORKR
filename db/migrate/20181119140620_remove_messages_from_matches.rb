class RemoveMessagesFromMatches < ActiveRecord::Migration[5.2]
  def change
    remove_column :matches, :messages, :text
  end
end
