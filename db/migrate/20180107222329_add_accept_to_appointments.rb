class AddAcceptToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :accept, :boolean
  end
end
