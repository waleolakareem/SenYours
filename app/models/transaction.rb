class Transaction < ApplicationRecord
  belongs_to :senior, :class_name => 'User', :foreign_key => 'senior_id'
  belongs_to :companion, :class_name => 'User', :foreign_key => 'companion_id'
end
