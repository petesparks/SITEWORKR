class AddEndDateToJobs < ActiveRecord::Migration[5.2]
  def change
    add_column :jobs, :end_date, :date
  end
end
