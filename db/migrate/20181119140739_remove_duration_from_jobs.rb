class RemoveDurationFromJobs < ActiveRecord::Migration[5.2]
  def change
    remove_column :jobs, :duration, :time
  end
end
