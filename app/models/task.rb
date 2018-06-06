class Task < ApplicationRecord
  has_many :join_users_tasks, dependent: :destroy
  has_many :users, through: :join_users_tasks
  belongs_to :service
end
