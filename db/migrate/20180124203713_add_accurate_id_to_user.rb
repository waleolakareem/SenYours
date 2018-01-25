class AddAccurateIdToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :accurate_customer_id, :string
  end
end
