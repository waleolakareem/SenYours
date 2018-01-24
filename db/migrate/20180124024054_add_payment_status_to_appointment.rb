class AddPaymentStatusToAppointment < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :payment_status, :string
  end
end
