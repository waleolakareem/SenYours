class AddAppointmentIdToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :appointment_id, :integer
  end
end
