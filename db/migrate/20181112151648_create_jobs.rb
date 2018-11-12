class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.references :user
      t.string :title
      t.string :location
      t.date :start_date
      t.date :duration
      t.integer :rate
      t.string :skill
      t.timestamps
    end
  end
end
