class AddHiredToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :hired, :boolean, default: false
    add_column :matches, :accepted, :boolean, default: false
  end
end
