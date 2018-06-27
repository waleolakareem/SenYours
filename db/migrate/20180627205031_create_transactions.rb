class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.string :stripe_transaction_id
      t.integer :amount
      t.integer :fee
      t.integer :payout
      t.references :senior 
      t.references :companion

      t.timestamps
    end
  end
end
