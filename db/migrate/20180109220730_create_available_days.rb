class CreateAvailableDays < ActiveRecord::Migration[5.1]
  def change
    create_table :available_days do |t|
      t.integer :user_id
      t.text :comment
      t.date :date

      t.timestamps
    end
  end
end
