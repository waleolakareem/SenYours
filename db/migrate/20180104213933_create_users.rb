class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :phone_number
      t.string :password_digest
      t.integer :zipcode
      t.string :state
      t.string :city
      t.string :address
      t.string :encrypted_ssn
      t.string :encrypted_ssn_iv
      t.integer :fee
      t.text :description
      t.string :avatar
      t.string :verification_image
      t.string :services_selected

      t.timestamps
    end
  end
end
