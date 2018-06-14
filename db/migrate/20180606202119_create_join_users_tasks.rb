class CreateJoinUsersTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :join_users_tasks do |t|
      t.integer :user_id
      t.integer :task_id

      t.timestamps
    end
  end
end
