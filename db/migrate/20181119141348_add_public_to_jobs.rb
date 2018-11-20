class AddPublicToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :public, :boolean, default: false
  end
end
