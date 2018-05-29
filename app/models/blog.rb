class Blog < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  self.per_page = 10



end
