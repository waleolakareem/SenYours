class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.integer :senior_id
      t.integer :companion_id
      t.time :start_time
      t.time :end_time
      t.date :start_date
      t.date :end_date
      t.integer :fee

      t.timestamps
    end
  end
end
