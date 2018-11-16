class AddMessagesToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :messages, :text, array: true, default: []
  end
end
