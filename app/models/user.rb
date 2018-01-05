class User < ApplicationRecord
  has_secure_password
  has_many :seniors, class_name: 'Appointment', foreign_key: 'senior_id'
  has_many :companions, class_name: 'Appointment', foreign_key: 'companion_id'
end
