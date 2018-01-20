class ChangeColName < ActiveRecord::Migration[5.1]
  def change
    rename_column :available_times, :available_Day_id, :available_day_id
  end
end
