class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :stripe_transaction_id
      t.integer :appointment_id
      t.integer :amount
      t.integer :fee
      t.integer :payout
      t.string :transaction_type
      t.string :status
      t.string :refund_id
      t.references :senior
      t.references :companion

      t.timestamps
    end
  end
end
