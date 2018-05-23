class AddIndexToAvailableTimesTime < ActiveRecord::Migration[5.1]
  def change
    add_index :available_times, :time
  end
end
