class Transaction < ApplicationRecord
  belongs_to :transaction_senior, :class_name => 'User', :foreign_key => 'transaction_senior_id'
  belongs_to :transaction_companion, :class_name => 'User', :foreign_key => 'transaction_companion_id'
end
