class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :user_id
      t.integer :service_id

      t.timestamps
    end
    add_index :tasks, :user_id
    add_index :tasks, :service_id
  end
end
