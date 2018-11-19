class AddFinishedToJobs < ActiveRecord::Migration[5.2]
  def change
        add_column :jobs, :finished?, :boolean, default: false
  end
end
