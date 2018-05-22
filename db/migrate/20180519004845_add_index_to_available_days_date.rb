class AddIndexToAvailableDaysDate < ActiveRecord::Migration[5.1]
  def change
    add_index :available_days, :date
  end
end
