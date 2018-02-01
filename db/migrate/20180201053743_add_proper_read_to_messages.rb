class AddProperReadToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :sender_read, :boolean, default: false, null: false
    add_column  :messages, :recipient_read, :boolean, default: false, null: false

    remove_column :messages, :read
  end
end
