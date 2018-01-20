class AvailableDay < ApplicationRecord
  belongs_to :user
  has_many :available_times
end
