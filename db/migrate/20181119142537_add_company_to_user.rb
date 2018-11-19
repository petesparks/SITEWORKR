class AddCompanyToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :company?, :boolean, default: false
  end
end
