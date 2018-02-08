class AddTosAndPrivacyToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :terms_of_service, :string
    add_column :users, :privacy_policy, :string
  end
end
