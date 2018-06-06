class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :service_id

      t.timestamps
    end
  end
end
