class ChangeIntegerLimitInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :phone_number, :integer, limit: 8
  end
end
