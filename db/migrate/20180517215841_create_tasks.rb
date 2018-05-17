class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.boolean :errands, :default => false
      t.boolean :companionship, :default => false
      t.boolean :doctor_appointment, :default => false
      t.boolean :gardening, :default => false
      t.boolean :preparing_meals, :default => false
      t.boolean :pet_care, :default => false
      t.boolean :shopping, :default => false
      t.boolean :transportation, :default => false
      
      t.timestamps
    end
  end
end
