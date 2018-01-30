class AddOtherInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :availability, :boolean
    add_column :users, :identification, :string
    add_column :users, :age, :integer
    add_column :users, :age_range, :string
  end
end
