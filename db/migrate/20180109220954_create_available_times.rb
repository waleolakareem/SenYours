class CreateAvailableTimes < ActiveRecord::Migration[5.1]
  def change
    create_table :available_times do |t|
      t.integer :availableday_id
      t.text :comment
      t.time :time

      t.timestamps
    end
  end
end
