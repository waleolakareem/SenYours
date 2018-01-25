class AvailableDay < ApplicationRecord
  belongs_to :user
  has_many :available_times, dependent: :destroy
end
