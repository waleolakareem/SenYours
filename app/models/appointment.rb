class Appointment < ApplicationRecord
  belongs_to :senior, class_name: 'User'
  belongs_to :companion, class_name: 'User'
end
